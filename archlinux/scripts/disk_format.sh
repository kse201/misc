# create new root partition
sgdisk --new=1:0:0 /dev/sda
# set legacy boot flag
sgdisk /dev/sda --attributes=1:set:2
# create 'safe' ext4 filesystem
mkfs.ext4 -q -L root /dev/sda1
# mount root for installation
mount /dev/sda1 /mnt
