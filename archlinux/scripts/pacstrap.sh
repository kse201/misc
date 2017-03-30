# Set mirror list

MIRRORLIST_PATH="/etc/pacman.d/mirrorlist"

function make_jp_mirrorlist(){
    mirror_file=$1
    cat <<'...' >${mirror_file}
## Japan
Server = http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/$repo/os/$arch
Server = http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/$repo/os/$arch
...
}

make_jp_mirrorlist "${MIRRORLIST_PATH}"

pacstrap /mnt base base-devel net-tools openssh dhcpcd grub

make_jp_mirrorlist "/mnt${MIRRORLIST_PATH}"

cat <<'...' >>/mnt/etc/pacman.conf

[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
...

arch-chroot /mnt pacman -S --noconfirm --refresh yaourt
