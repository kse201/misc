#include "msock.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <poll.h>

#define MULTICAST_SO_RCVBUF 300000
#define FD_NUM 2

SOCKET sockv4;   /* Socket */
SOCKET sockv6; /* Socket v6 */
char *recvBuf; /* Buffer for received data */

static void print_sockaddr(struct sockaddr_in *addr) {
  char addrstr[256];
  char family[256];
  int port = ntohs(addr->sin_port);

  if (addr->sin_family == AF_INET) {
    strcpy(family, "IPv4");
    inet_ntop(AF_INET, &((struct sockaddr_in *)addr)->sin_addr, addrstr,
              sizeof(addrstr));
  } else {
    strcpy(family, "IPv6");
    inet_ntop(AF_INET6, &((struct sockaddr_in6 *)addr)->sin6_addr, addrstr,
              sizeof(addrstr));
  }

  printf("%s %d from %s\n", family, port, addrstr);
}

static void DieWithError(char *errorMessage) {
  fprintf(stderr, "%s\n", errorMessage);
  if (sockv4 >= 0)
    close(sockv4);
  if (sockv6 >= 0)
    close(sockv6);
  if (recvBuf)
    free(recvBuf);

  exit(EXIT_FAILURE);
}

int main(int argc, char *argv[]) {
  char *multicastIP;   /* Arg: IP Multicast Address */
  char *multicastPort; /* Arg: Port */
  int recvBufLen;      /* Length of receive buffer */
  SOCKET sock = -1;
  struct pollfd fds[FD_NUM];
  struct sockaddr from;
  socklen_t sockaddr_in_size = sizeof(struct sockaddr_in);

  if (argc != 4) {
    fprintf(stderr,
            "Usage: %s <Multicast IP> <Multicast Port> <Receive Buffer Size>\n",
            argv[0]);
    exit(EXIT_FAILURE);
  }

  multicastIP = argv[1];   /* First arg:  Multicast IP address */
  multicastPort = argv[2]; /* Second arg: Multicast port */
  recvBufLen = atoi(argv[3]);

  recvBuf = malloc(recvBufLen * sizeof(char));

  sockv4 = mcast_recv_socket(multicastIP, multicastPort, MULTICAST_SO_RCVBUF);

  if (sockv4 < 0) {
    DieWithError("mcast_recv_socket() failed in ipv4");
  } else {
    fds[0].fd = sockv4;
    fds[0].events = POLLIN | POLLERR;
  }

  sockv6 = mcast_recv_socket("ff02::1%eth3", multicastPort, MULTICAST_SO_RCVBUF);
  if (sockv6 < 0){
    DieWithError("mcast_recv_socket() failed in ipv6");
  } else {
    fds[1].fd = sockv6;
    fds[1].events = POLLIN | POLLERR;
  }

  int rcvd = 0;
  int lost = 0;

  int last_p = -1;
  for (;;) /* Run forever */
  {
    time_t timer;
    int bytes = 0;
    printf("waiting...\n");
    poll(fds, FD_NUM, -1);

    if (fds[0].revents & POLLIN) {
      sock = fds[0].fd;
    } else if (fds[1].revents & POLLIN) {
      sock = fds[1].fd;
    }

    /* Receive a single datagram from the server */
    if ((bytes = recvfrom(sock, recvBuf, recvBufLen, 0, &from, &sockaddr_in_size)) < 0)
      DieWithError("recvfrom() failed");

    ++rcvd;
    int this_p = ntohl(*(int *)recvBuf);

    if (last_p >= 0) /* only check on the second and later runs */
    {
      if (this_p - last_p > 1)
        lost += this_p - (last_p + 1);
    }
    last_p = this_p;

    /* Print the received string */
    time(&timer); /* get time stamp to print with recieved data */
    printf("Packets recvd %d, lost %d, loss ratio %f\n", rcvd, lost,
           (double)lost / (double)(rcvd + lost));
    print_sockaddr((struct sockaddr_in *)&from);
    printf("Time Received: %.*s : packet %d, %d bytes\n",
           (int)strlen(ctime(&timer)) - 1, ctime(&timer), this_p, bytes);
  }

  /* NOT REACHED */
  exit(EXIT_SUCCESS);
}
