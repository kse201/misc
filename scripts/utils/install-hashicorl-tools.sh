#!/bin/sh -eu

tmpdir=$(mktemp -d)
atexit() {
      [ -n "$tmpdir" ] && rm -rf "$tmpdir"
  }
  trap atexit EXIT
trap 'trap - EXIT; atexit; exit -1' SIGHUP SIGINT SIGTERM

os="linux"
arch="amd64"

for i in \
    terraform,0.9.8 \
    packer,1.0.0 \
    nomad,0.5.6 \
    consul,0.8.3 \
    serf,0.8.1 \
    vault,0.7.3 \
    ;  do

    IFS="," ; set -- $i
    tool=$1
    version=$2
    curl -L -o "${tmpdir}/${tool}.zip" "https://releases.hashicorp.com/${tool}/${version}/${tool}_${version}_${os}_${arch}.zip"
    unzip "${tmpdir}/${tool}.zip" -d "${tmpdir}"
    sudo mv "${tmpdir}/${tool}" /usr/local/bin
done

rm -rf "${tmpdir}"
