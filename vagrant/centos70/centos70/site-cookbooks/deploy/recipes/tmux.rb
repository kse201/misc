#
# Cookbook Name:: deploy
# Recipe:: tmux
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

# tmux

%w(wget gcc make ncurses ncurses-devel).each do |pkg|
  package pkg do
    action :install
  end
end

libevent = "libevent-#{node[:deploy][:libevent][:version]}-stable"
remote_file "#{Chef::Config[:file_cache_path]}/#{libevent}.tar.gz" do
  source "https://github.com/downloads/libevent/libevent/#{libevent}.tar.gz"
  notifies :run, 'execute[install_libevent]'
end

execute 'install_libevent' do
  command <<-EOF
    cd #{Chef::Config[:file_cache_path]}
    tar xzf #{libevent}.tar.gz
    cd #{libevent}
    ./configure
    make && make install
    echo "/usr/local/lib" > /etc/ld.so.conf.d/libevent.conf
    ldconfig
  EOF
  action :nothing
end

tmux = "tmux-#{node[:deploy][:tmux][:version]}"
remote_file "#{Chef::Config[:file_cache_path]}/#{tmux}.tar.gz" do
  source "http://downloads.sourceforge.net/tmux/#{tmux}.tar.gz"
  notifies :run, 'execute[install_tmux]'
end

execute 'install_tmux' do
  command <<-EOF
    cd #{Chef::Config[:file_cache_path]}
    tar xzf #{tmux}.tar.gz
    cd #{tmux}
    ./configure
    make && make install
  EOF
  action :nothing
end
