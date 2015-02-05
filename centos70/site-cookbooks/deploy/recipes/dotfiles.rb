#
# Cookbook Name:: deploy
# Recipe:: dotfiles
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

git "#{node['deploy']['home']}/.dotfiles" do
    repository node['deploy']['dotfiles']['repository']
    reference node['deploy']['dotfiles']['branch']
    action :checkout
    enable_submodules true
    user node['deploy']['user']
    group node['deploy']['group']
end

node['deploy']['dotfiles']['item'].each do  | file | 
    link "#{node['deploy']['home']}/#{file}" do
        to "#{node['deploy']['home']}/.dotfiles/#{file}"
    end
end

directory  "#{node['deploy']['home']}/.vim/bundle" do
    owner node['deploy']['user']
    group node['deploy']['group']
end

node['deploy']['dotfiles']['shougowares'].each do | shougoware |  
    git "#{node['deploy']['home']}/.vim/bundle/#{shougoware}" do
        repository "https://github.com/Shougo/#{shougoware}"
        reference "master"
        action :checkout
        user node['deploy']['user']
        group node['deploy']['group']
    end
end

