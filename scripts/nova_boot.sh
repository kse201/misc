#!/bin/sh

nova boot \
  --flavor 'm1.small' \
  --image 'CentOS 7.2' \
  --availability-zone nova \
  --key-name default \
  --security-groups default \
  --nic net-id=$(neutron net-show private-net | awk '/ id/ { print$4}') \
  --nic net-id=$(neutron net-show develop-net | awk '/ id / {print $4}') \
  --nic net-id=$(neutron net-show ct-net | awk '/ id / {print $4}') \
  net-test
