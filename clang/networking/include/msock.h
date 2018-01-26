#ifndef MSOCK_H
#define MSOCK_H

#include <arpa/inet.h>
#include <errno.h>
#include <net/if.h>
#include <netdb.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

//! ソケット
#define SOCKET int

/* Define IPV6_ADD_MEMBERSHIP for FreeBSD and Mac OS X */
#ifndef IPV6_ADD_MEMBERSHIP
#define IPV6_ADD_MEMBERSHIP IPV6_JOIN_GROUP
#endif

/**
  @fn SOCKET mcast_send_socket(char* multicastIP, char* multicastPort, int
  multicastTTL, struct addrinfo **multicastAddr, char *interface);

  @details
    マルチキャスト送信用ソケットを作成する。
    作成に失敗した場合 -1を返す。
  @param[in] multicastIP 送信先マルチアドレス
  @param[in] multicastPort 送信先ポート
  @param[in] multicastTTL マルチパケットTTL
  @param[in] *interface 送信先インタフェース名
  @param[out] **multicastAddr マルチアドレス 構造体
  @return
      - >= 0 : ソケット
      - -1   : 異常終了
*/
SOCKET mcast_send_socket(char *multicastIP, char *multicastPort,
                         int multicastTTL, struct addrinfo **multicastAddr,
                         char *interface);

/**
  @fn SOCKET mcast_recv_socket(char* multicastIP, char* multicastPort, int
  multicastRecvBufSize);
  @details
    マルチキャスト受信用ソケットを作成する。
    作成に失敗した場合 -1を返す。
  @param[in] *multicastIP 受信先マルチアドレス
  @param[in] *multicastPort 受信先ポート
  @param[in] multicastRecvBufSize 受信パケットサイズ上限
  @return
      - >= 0 : ソケット
      - -1   : 異常終了
*/
SOCKET mcast_recv_socket(char *multicastIP, char *multicastPort,
                         int multicastRecvBufSize);

/**
  @fn int mcast_send(char *multicastIP, char *multicastPort, int ttl, char
  *message, size_t len, char *interface);

  @details
      マルチキャストアドレスにUDPでメッセージを送信する。
  @param[in] *multicastIP 受信先マルチアドレス
  @param[in] *multicastPort 受信先UDPポート
  @param[in] ttl パケットのTTL
  @param[in] *message 送信メッセージ
  @param[in] len 送信メッセージ長
  @param[in] *interface 送信先インタフェース
  @return
      - 0 : 正常終了
      - 1 : 異常終了
*/
int mcast_send(char *multicastIP, char *multicastPort, int ttl, char *message,
               size_t len, char *interface);

#endif
