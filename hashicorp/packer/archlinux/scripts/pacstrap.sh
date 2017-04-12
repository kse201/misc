#!/bin/sh

disk_format(){
    # create new root partition
    sgdisk --zap-all /dev/sda

    if [ -e '/sys/firmware/efi/efivars' ] ; then
        # EFI
        sgdisk --mbrtogpt /dev/sda
        sgdisk --new=1:0:512M /dev/sda
        sgdisk --typecode=1:EF00 /dev/sda

        sgdisk --new=2:0:0 /dev/sda
        sgdisk --typecode=2:8300 /dev/sda

        # create 'safe' ext4 filesystem
        mkfs.vfat -F 32 /dev/sda1
        mkfs.ext4 -q -L root /dev/sda2
        # mount root for installation
        mount /dev/sda2 /mnt
        mkdir /mnt/boot
        mount /dev/sda1 /mnt/boot
    else
        # BIOS
        # create new root partition
        sgdisk --new=1:0:0 /dev/sda
        # set legacy boot flag
        sgdisk /dev/sda --attributes=1:set:2
        # create 'safe' ext4 filesystem
        mkfs.ext4 -q -L root /dev/sda1
        # mount root for installation
        mount /dev/sda1 /mnt
    fi
}

make_jp_mirrorlist(){
    mirror_file=$1
    cat <<'...' >"${mirror_file}"
    ## Japan
    Server = http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/$repo/os/$arch
    Server = http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/$repo/os/$arch
...
}

pacstrap(){
    # Set mirror list

    MIRRORLIST_PATH="/etc/pacman.d/mirrorlist"
    chroot='arch-chroot /mnt'

    make_jp_mirrorlist "${MIRRORLIST_PATH}"

    pacstrap /mnt base base-devel net-tools openssh dhcpcd

    make_jp_mirrorlist "/mnt${MIRRORLIST_PATH}"

    cat <<'...' >>/mnt/etc/pacman.conf

[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
...

    $chroot pacman -S --noconfirm --refresh yaourt

    # make boot-loader
    if [ -e '/sys/firmware/efi/efivars' ] ; then
        # EFI
        $chroot pacman -S --noconfirm grub dosfstools efibootmgr
        $chroot grub-install \
            --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch_grub \
            --force --recheck /dev/sda
        $chroot grub-mkconfig -o /boot/grub/grub.cfg
        $chroot mkdir -p /boot/EFI/boot
        $chroot cp /boot/EFI/arch_grub/grubx64.efi  /boot/EFI/boot/bootx64.efi
    else
        # BIOS
        $chroot pacman -S --noconfirm grub
        $chroot grub-install \
            --force --recheck /dev/sda
        $chroot grub-mkconfig -o /boot/grub/grub.cfg
    fi
    genfstab -p /mnt >> /mnt/etc/fstab
}

configration(){
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
}

vagrant_configuration(){
    chroot='arch-chroot /mnt'

    ${chroot} pacman -S --noconfirm \
        virtualbox-guest-utils virtualbox-guest-modules-arch

    # create vagrant user
    ${chroot} groupadd vagrant
    ${chroot} useradd -p "$(openssl passwd -crypt 'vagrant')" \
        -c 'vagrant user' -g vagrant -G vboxsf -d /home/vagrant \
        -s /bin/bash -m vagrant

    # set sudoers
    echo -e "Defaults env_keep += \"SSH_AUTH_SOCK\"\nvagrant ALL=(ALL) NOPASSWD: ALL" \
        > /mnt/etc/sudoers.d/vagrant
    chmod 0440 /mnt/etc/sudoers.d/vagrant

    # create vagrant's home directory
    ${chroot} install -dm0700 -g vagrant -o vagrant /home/vagrant/.ssh
    # set vagrant's authorized_keys
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" \
        > /mnt/home/vagrant/.ssh/authorized_keys
    ${chroot} chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
    ${chroot} chmod 0600 /home/vagrant/.ssh/authorized_keys

    ${chroot} echo 'archlinux.vagrant' > /etc/hostname
    ${chroot} sed -i 's/archlinux.localdomain/archlinux.vagrant/' /etc/hostname

    ${chroot} systemctl enable vboxservice

    # disable root user
    ${chroot} passwd root -l
}

post_install(){
    # remove caches
    yes | arch-chroot /mnt pacman -Scc

    # Zero out the free space to save space in the final image:
    dd if=/dev/zero of=/mnt/ZERO bs=1M
    rm -f /mnt/ZERO
}

disk_format
pacstrap
configration
vagrant_configuration
post_install
