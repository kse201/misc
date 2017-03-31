chroot='arch-chroot /mnt'
$chroot grub-install --force --recheck /dev/sda
$chroot grub-mkconfig -o /boot/grub/grub.cfg
genfstab -p /mnt >> /mnt/etc/fstab

# basic configuration
$chroot loadkeys jp106

$chroot sed -i \
    -e 's/#en_US.UTF-8/en_US.UTF-8/' \
    -e 's/#ja_JP.UTF-8/ja_JP.UTF-8/' \
    /etc/locale.gen
$chroot locale-gen
$chroot timedatectl set-timezone Asia/Tokyo
$chroot hostnamectl set-hostname 'archlinux.localdomain'

$chroot systemctl enable dhcpcd
$chroot systemctl enable sshd
