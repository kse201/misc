#!/bin/sh -eu

tmpdir=$(mktemp -d)
atexit() {
      [ -n "$tmpdir" ] && rm -rf "$tmpdir"
  }
  trap atexit EXIT
trap 'trap - EXIT; atexit; exit -1' SIGHUP SIGINT SIGTERM

for i in \
    echo-sd,"https://git.io/echo-sd" \
    unko.tower,"https://git.io/unko.tower" \
    echo-meme,"https://git.io/echo-meme" \
    ; do

    IFS="," ; set -- $i
    tool=$1
    url=$2
    curl -L -o "${tmpdir}/${tool}" "${url}"
    chmod +x "${tmpdir}/${tool}"
    sudo mv "${tmpdir}/${tool}" /usr/local/bin

done

