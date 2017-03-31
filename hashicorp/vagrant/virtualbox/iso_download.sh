#!/bin/sh
DATETIME=2017.03.01
FILENAME=archlinux-${DATETIME}-dual.iso
wget -O $FILENAME \
  "http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/iso/${DATETIME}/$FILENAME"
