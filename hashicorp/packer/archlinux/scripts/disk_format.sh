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
