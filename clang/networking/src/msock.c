#include "msock.h"

void debug_print_addrinfo(struct addrinfo *rp) {
  struct sockaddr_in *addr;
  char addrstr[256];
  fprintf(stdout, "ai_family: %d\n", rp->ai_family);
  fprintf(stdout, "ai_socktype: %d\n", rp->ai_socktype);
  fprintf(stdout, "ai_protocol: %d\n", rp->ai_protocol);
  fprintf(stdout, "ai_addrlen: %d\n", rp->ai_addrlen);
  fprintf(stdout, "ai_canonname: %s\n", rp->ai_canonname);

  addr = (struct sockaddr_in *)rp->ai_addr;
  fprintf(stdout, "ai_addr->sin_family: %d\n", addr->sin_family);
  fprintf(stdout, "ai_addr->sin_port: %d\n", ntohs(addr->sin_port));
  if (rp->ai_family == AF_INET) {
    inet_ntop(AF_INET, &((struct sockaddr_in *)addr)->sin_addr, addrstr,
              sizeof(addrstr));
  } else {
    inet_ntop(AF_INET6, &((struct sockaddr_in6 *)addr)->sin6_addr, addrstr,
              sizeof(addrstr));
  }
  fprintf(stdout, "ai_addr->s_addr: %s\n", addrstr);
}

SOCKET mcast_send_socket(char *multicastIP, char *multicastPort,
                         int multicastTTL, struct addrinfo **multicastAddr,
                         char *interface) {
  SOCKET sock;
  int status;
  struct addrinfo hints = {0};
  struct ifreq ifr;

  hints.ai_family = PF_UNSPEC;
  hints.ai_socktype = SOCK_DGRAM;
  hints.ai_flags = AI_NUMERICHOST;

  status = getaddrinfo(multicastIP, multicastPort, &hints, multicastAddr);
  if (status != EXIT_SUCCESS) {
    fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(status));
    return -1;
  }

  sock = socket((*multicastAddr)->ai_family, (*multicastAddr)->ai_socktype, 0);
  if (sock < 0) {
    perror("socket() failed");
    goto error;
  }

  if ((*multicastAddr)->ai_family == PF_INET) {
    status = setsockopt(sock, IPPROTO_IP, IP_MULTICAST_TTL,
                        (char *)&multicastTTL, sizeof(multicastTTL));
  } else if ((*multicastAddr)->ai_family == PF_INET6) {
    status = setsockopt(sock, IPPROTO_IPV6, IPV6_MULTICAST_HOPS,
                        (char *)&multicastTTL, sizeof(multicastTTL));
  }
  if (status != EXIT_SUCCESS) {
    perror("setsockopt() failed");
    goto error;
  }

  if ((*multicastAddr)->ai_family == PF_INET) {
    ifr.ifr_addr.sa_family = AF_INET;
    strncpy(ifr.ifr_name, interface, IFNAMSIZ - 1);
    ioctl(sock, SIOCGIFADDR, &ifr);

    in_addr_t iface = ((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr.s_addr;
    status = setsockopt(sock, IPPROTO_IP, IP_MULTICAST_IF, (char *)&iface,
                        sizeof(iface));
  } else if ((*multicastAddr)->ai_family == PF_INET6) {
    unsigned int ifindex = 0;
    status = setsockopt(sock, IPPROTO_IPV6, IPV6_MULTICAST_IF, (char *)&ifindex,
                        sizeof(ifindex));
  }

  if (status != EXIT_SUCCESS) {
    perror("setsockopt() failed");
    goto error;
  }

  return sock;

error: // 後処理して異常終了
  freeaddrinfo(*multicastAddr);
  return -1;
}

SOCKET mcast_recv_socket(char *multicastIP, char *multicastPort,
                         int multicastRecvBufSize) {
  SOCKET sock;
  struct addrinfo hints = {0};
  struct addrinfo *localAddr = 0;
  struct addrinfo *multicastAddr = 0;
  int yes = 1;
  int status;

  hints.ai_family = PF_UNSPEC;
  hints.ai_flags = AI_NUMERICHOST;
  status = getaddrinfo(multicastIP, NULL, &hints, &multicastAddr);
  if (status != EXIT_SUCCESS) {
    fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(status));
    return -1;
  }

  hints.ai_family = multicastAddr->ai_family;
  hints.ai_socktype = SOCK_DGRAM;
  hints.ai_flags = AI_PASSIVE;
  status = getaddrinfo(NULL, multicastPort, &hints, &localAddr);
  if (status != EXIT_SUCCESS) {
    fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(status));
    goto error;
  }

  sock = socket(localAddr->ai_family, localAddr->ai_socktype, 0);
  if (sock < 0) {
    perror("socket() failed");
    goto error;
  }

  /* reuse socket */
  status =
      setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, (char *)&yes, sizeof(int));
  if (status != EXIT_SUCCESS) {
    perror("setsockopt");
    goto error;
  }

  status = bind(sock, localAddr->ai_addr, localAddr->ai_addrlen);
  if (status != EXIT_SUCCESS) {
    perror("bind error");
    goto error;
  }

  /* set buffer size */
  int optval = 0;
  socklen_t optval_len = sizeof(optval);
  status =
      getsockopt(sock, SOL_SOCKET, SO_RCVBUF, (char *)&optval, &optval_len);
  if (status != EXIT_SUCCESS) {
    perror("getsockopt");
    goto error;
  }

  optval = multicastRecvBufSize;
  if (setsockopt(sock, SOL_SOCKET, SO_RCVBUF, (char *)&optval,
                 sizeof(optval)) != 0) {
    perror("setsockopt");
    goto error;
  }
  if (getsockopt(sock, SOL_SOCKET, SO_RCVBUF, (char *)&optval, &optval_len) !=
      0) {
    perror("getsockopt");
    goto error;
  }

  /* Join the multicast group. We do this seperately depending on whether we
   * are using IPv4 or IPv6.
   */
  if (multicastAddr->ai_family == PF_INET &&
      multicastAddr->ai_addrlen == sizeof(struct sockaddr_in)) /* IPv4 */
  {
    struct ip_mreq multicastRequest; /* Multicast address join structure */

    /* Specify the multicast group */
    memcpy(&multicastRequest.imr_multiaddr,
           &((struct sockaddr_in *)(multicastAddr->ai_addr))->sin_addr,
           sizeof(multicastRequest.imr_multiaddr));

    /* Accept multicast from any interface */
    multicastRequest.imr_interface.s_addr = htonl(INADDR_ANY);

    /* Join the multicast address */
    if (setsockopt(sock, IPPROTO_IP, IP_ADD_MEMBERSHIP,
                   (char *)&multicastRequest, sizeof(multicastRequest)) != 0) {
      perror("setsockopt() failed");
      goto error;
    }
  } else if (multicastAddr->ai_family == PF_INET6 &&
             multicastAddr->ai_addrlen ==
                 sizeof(struct sockaddr_in6)) /* IPv6 */
  {
    struct ipv6_mreq multicastRequest; /* Multicast address join structure */

    /* Specify the multicast group */
    memcpy(&multicastRequest.ipv6mr_multiaddr,
           &((struct sockaddr_in6 *)(multicastAddr->ai_addr))->sin6_addr,
           sizeof(multicastRequest.ipv6mr_multiaddr));

    /* Accept multicast from any interface */
    multicastRequest.ipv6mr_interface = 0;

    /* Join the multicast address */
    if (setsockopt(sock, IPPROTO_IPV6, IPV6_ADD_MEMBERSHIP,
                   (char *)&multicastRequest, sizeof(multicastRequest)) != 0) {
      perror("setsockopt() failed");
      goto error;
    }
  } else {
    perror("Neither IPv4 or IPv6");
    goto error;
  }

  if (localAddr)
    freeaddrinfo(localAddr);
  if (multicastAddr)
    freeaddrinfo(multicastAddr);

  return sock;

error: // 後処理して異常終了
  if (localAddr)
    freeaddrinfo(localAddr);
  if (multicastAddr)
    freeaddrinfo(multicastAddr);

  return -1;
}

int mcast_send(char *multicastIP, char *multicastPort, int ttl, char *message,
               size_t len, char *interface) {
  SOCKET sock;
  int status;
  struct addrinfo *mcastAddr;

  sock =
      mcast_send_socket(multicastIP, multicastPort, ttl, &mcastAddr, interface);
  if (sock < 0) {
    perror("failed mcast_send_socket");
    return EXIT_FAILURE;
  }

  status =
      sendto(sock, message, len, 0, mcastAddr->ai_addr, mcastAddr->ai_addrlen);
  if (status == -1) {
    perror("failed sendto");
    (void)close(sock);
    return EXIT_FAILURE;
  }

  (void)close(sock);
  return 0;
}
