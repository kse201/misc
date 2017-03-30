arch-chroot /mnt grub-install --force --recheck /dev/sda
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
genfstab -p /mnt >> /mnt/etc/fstab

# basic configuration
echo 'KEYMAP=jp106' > /mnt/etc/vconsole.conf

sed -i \
    -e 's/#en_US.UTF-8/en_US.UTF-8/' \
    -e 's/#ja_JP.UTF-8/ja_JP.UTF-8/' \
    /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
arch-chroot /mnt timedatectl set-timezone Asia/Tokyo
arch-chroot /mnt hostnamectl set-hostname 'archlinux.localdomain'

arch-chroot /mnt systemctl enable dhcpcd
arch-chroot /mnt systemctl enable sshd
