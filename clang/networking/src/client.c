#include "msock.h"

static void DieWithError(char *errorMessage) {
  fprintf(stderr, "%s\n", errorMessage);
  exit(EXIT_FAILURE);
}

int main(int argc, char *argv[]) {
  char *multicastIP;    /* Arg: IP Multicast address */
  char *multicastPort;  /* Arg: Server port */
  char *interface;      /* Arg: Interface to send packet */
  char *sendString, *ptr;     /* Arg: String to multicast */
  int sendStringLen = 0;    /* Length of string to multicast */
  int multicastTTL = 1; /* Arg: TTL of multicast packets */

  int i;

  if (argc < 5) {
    fprintf(stderr,
            "Usage: %s <Multicast Address> <Port> <Interface> <message...>\n",
            argv[0]);
    exit(EXIT_FAILURE);
  }

  multicastIP = argv[1];   /* First arg:   multicast IP address */
  multicastPort = argv[2]; /* Second arg:  multicast port */
  interface = argv[3];

  for (i = 4; i < argc ; i++ ) {
    sendStringLen+= strlen(argv[i]);
    sendStringLen++;
    fprintf(stderr,"%s: %d\n", argv[i], (int)strlen(argv[i]));
  }
  sendStringLen--;
  sendString = (char *)calloc(sizeof(char),sendStringLen);

  ptr = sendString;
  for (i = 4; i < argc ; i++ ) {
    strncpy(ptr, argv[i], strlen(argv[i]));
    ptr += strlen(argv[i]);
    *ptr = ' '; ptr++;
  }

  if (mcast_send(multicastIP, multicastPort, multicastTTL, sendString, sendStringLen,
                 interface) != 0)
    DieWithError("sendto() sent a different number of bytes than expected");

  fprintf(stdout, "packet sent %s\n", sendString);
  free(sendString);
  return 0;
}
