#!/bin/sh

datetime='2017.03.01'
filename="archlinux-${datetime}-dual.iso"
wget -O ${filename} \
    "http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/iso/${datetime}/${filename}"

wget -O md5sums.txt \
    "http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/iso/${datetime}/md5sums.txt"
