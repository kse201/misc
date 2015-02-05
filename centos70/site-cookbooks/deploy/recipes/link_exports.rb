#
# Cookbook Name:: deploy
# Recipe:: link_exports
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

link "/home/vagrant/.log" do
  to "/export/log"
end

link "/home/vagrant/work" do
  to "/export/work"
end
