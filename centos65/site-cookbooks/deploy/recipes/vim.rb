#
# Cookbook Name:: deploy
# Recipe:: vim
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

# vim

node[:deploy][:vim][:dependencies].each do |pkg|
  package pkg do
    action :install
  end
end

execute "get vim source code" do
  command <<-EOF
    hg clone https://vim.googlecode.com/hg #{node[:deploy][:vim][:src_dir]}/vim
  EOF
  creates "#{node[:deploy][:vim][:src_dir]}/vim"
end

execute "compile vim" do
  command <<-EOF
    cd #{node[:deploy][:vim][:src_dir]}/vim
    hg update
    ./configure #{node[:deploy][:vim][:compile_options]}
    make && make install
  EOF
end
