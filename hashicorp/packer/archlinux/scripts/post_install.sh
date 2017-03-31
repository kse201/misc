# remove caches
yes | arch-chroot /mnt pacman -Scc

# Zero out the free space to save space in the final image:
dd if=/dev/zero of=/mnt/ZERO bs=1M
rm -f /mnt/ZERO
