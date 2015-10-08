#!/bin/sh -e

CHEF_ROOT_DIR="/vagrant"

echo "cookbook_path [\"${CHEF_ROOT_DIR}/cookbooks\", \"${CHEF_ROOT_DIR}/site-cookbooks\", \"${CHEF_ROOT_DIR}/berks-cookbooks\"]" > solo.rb
echo "node_name \"localhost.localdomain\"" >> solo.rb
echo "environment_path \"${CHEF_ROOT_DIR}/environments\"" >> solo.rb

## Enable proxy if necessary
for n in http_proxy https_proxy no_proxy http_proxy_user http_proxy_pass https_proxy_user https_proxy_pass
do
  if [ -n "${!n}" ] ; then
    echo "${n} \"${!n}\"" >> solo.rb
  fi
done

# Run chef-solo
for chef_dir in /opt/chefdk/bin /opt/chef/bin ; do
  if [ -x "${chef_dir}/chef-solo" ] ; then
    CHEF_SOLO="${chef_dir}/chef-solo"
    break
  fi
done

if [ -z "${CHEF_SOLO}" ] ; then
  echo "Cannot find any chef-solo binary"
  exit 1
fi

${CHEF_SOLO} -c ./solo.rb $*
