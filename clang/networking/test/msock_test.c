#include <cutter.h>
#include "msock.h"

void test_mcast_recv_socket(void) {
  SOCKET sock;

  sock = mcast_recv_socket("ff02::1%enp0s8", "12081", 255);
  cut_assert_true(sock >= 0, cut_message("インタフェース名を確認してください"));
  if (sock >= 0) {
    close(sock);
  }

  sock = mcast_recv_socket("ff02::1%enp0ss", "12081", 255);
  cut_assert_true(sock < 0, cut_message("インタフェース名を確認してください"));
  if (sock >= 0) {
    close(sock);
  }

  sock = mcast_recv_socket("224.0.0.1", "12081", 255);
  cut_assert_true(sock >= 0);
  if (sock >= 0) {
    close(sock);
  }

  sock = mcast_recv_socket("221.0.0.1", "12081", 255);
  cut_assert_true(sock < 0);
  if (sock >= 0) {
    close(sock);
  }
}

void test_mcast_send_socket(void) {
  SOCKET sock;
  struct addrinfo *mcastAddr;

  sock = mcast_send_socket("ff02::1%enp0s8", "12081", 10, &mcastAddr, "enp0s8");
  cut_assert_true(sock >= 0, cut_message("インタフェース名を確認してください"));
  if (sock >= 0) {
    close(sock);
  }

  sock = mcast_send_socket("ff02::1%enp0s9", "12081", 10, &mcastAddr, "enp0s9");
  cut_assert_true(sock < 0, cut_message("インタフェース名を確認してください"));
  if (sock >= 0) {
    close(sock);
  }

  sock = mcast_send_socket("224.0.0.1", "12081", 10, &mcastAddr, "enp0s8");
  cut_assert_true(sock >= 0);
  if (sock >= 0) {
    close(sock);
  }
}

void test_mcast_send(void) {
  int status;
  status = mcast_send("ff02::1%enp0s8", "12081", 10, "foo bar", strlen("foo bar"), "enp0s8");
  cut_assert_equal_int(0, status, cut_message("インタフェース名を確認してください"));

  status = mcast_send("ff02::1%enp0s9", "12081", 10, "foo bar", strlen("foo bar"), "enp0s9");
  cut_assert_equal_int(1, status, cut_message("インタフェース名を確認してください"));
}
