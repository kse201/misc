chroot='arch-chroot /mnt'

$chroot echo KEYMAP=jp106 > /etc/vconsole.conf

$chroot sed -i \
    -e 's/#en_US.UTF-8/en_US.UTF-8/' \
    -e 's/#ja_JP.UTF-8/ja_JP.UTF-8/' \
    /etc/locale.gen
$chroot locale-gen
$chroot ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
$chroot echo 'archlinux.localdomain' > /etc/hostname
$chroot echo '127.0.1.1    archlinux.localdomain archlinux' \
        >> /etc/hostname

$chroot systemctl enable dhcpcd
$chroot systemctl enable sshd
