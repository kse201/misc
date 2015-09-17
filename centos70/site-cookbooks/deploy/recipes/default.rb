#
# Cookbook Name:: deploy
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'deploy::dotfiles'
include_recipe 'deploy::packages'
include_recipe 'deploy::link_exports'
