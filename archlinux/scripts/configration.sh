chroot='arch-chroot /mnt'

$chroot loadkeys jp106

$chroot sed -i \
    -e 's/#en_US.UTF-8/en_US.UTF-8/' \
    -e 's/#ja_JP.UTF-8/ja_JP.UTF-8/' \
    /etc/locale.gen
$chroot locale-gen
arch-chroot /mnt ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
$chroot echo 'archlinux.localdomain' > /etc/hostname

$chroot systemctl enable dhcpcd
$chroot systemctl enable sshd
