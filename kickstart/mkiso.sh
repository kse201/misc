#!/bin/sh

yum -y install mkisofs

wget http://ftp.jaist.ac.jp/pub/Linux/CentOS/7/isos/x86_64/CentOS-7-x86_64-Minimal-1611.iso
mount CentOS-7-x86_64-Minimal-1611.iso /mnt

mkdir ~/base
cp -R /mnt ~/base

cp ks.cfg ~/base/isolinux/ks.cfg
cp isolinux.cfg ~/base/isolinux/isolinux.cfg
cd ~/base

mkisofs \
   -v -r -J \
   -o ~/CentOS-7-x86_64-kickstart.iso \
   -b isolinux/isolinux.bin  \
   -c isolinux/boot.cat \
   -boot-info-table \
   -boot-load-size 4 \
   -no-emul-boot \
   -eltorito-alt-boot \
   -e images/efiboot.img \
   -no-emul-boot .
