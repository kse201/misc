#!/bin/sh -eu

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

echo "Step (1/3): Packaging"
pushd ../
tar czf ${archive}.tgz ${archive}

echo "Step (2/3): Deploy"
ssh ${target} mkdir -p ${dest_dir}
scp ${archive}.tgz ${target}:${dest_dir}/

ssh ${target} tar xz -C ${dest_dir} -f ${dest_dir}/${archive}.tgz

echo "Step (3/3): Clean-up"
ssh ${target} rm ${dest_dir}/${archive}.tgz
rm ${archive}.tgz

echo "All Steps Finished!"
