#
# Cookbook Name:: deploy
# Recipe:: packages
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
include_recipe 'deploy::vim'

package 'screen' do
  action :install
end
