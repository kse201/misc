#!/bin/sh
USAGE=$(echo '
Usage:
  burn-raspbian.sh <img path>

  Support OS: macOS
')
if [ "$1" = '-h' ] ; then
    echo "${USAGE}"
    exit 0
fi

disk=$(diskutil list | awk '/external/ { print $1}')
img="${1}"
echo $ "diskutil unmountDisk ${disk}"
eval "diskutil unmountDisk ${disk}"
echo $ "sudo dd bs=1m if=${img} of=${disk}"
eval "sudo dd bs=1m if=${img} of=${disk}"
