#!/bin/sh

usage() {
    cat <<...
Usage: delivery.sh host dest_dir
  deploy current directry into target host/path
  host     : target host to deploy
  dest_dir : destination path
...
}

if [ $# -lt 2 ] ; then
    usage
    exit 1
fi

archive=$(basename $PWD)
target=$1
dest_dir=$2

pushd ../
tar czf ${archive}.tgz ${archive}
ssh ${target} mkdir -p ${dest_dir}
scp ${archive}.tgz ${target}:${dest_dir}/
ssh ${target} tar xz -C ${dest_dir} -f ${dest_dir}/${archive}.tgz
