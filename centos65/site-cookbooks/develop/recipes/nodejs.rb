#
# Cookbook Name:: develop
# Recipe:: nodejs
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

yum_packages=%w[
  nodejs
  npm
  redis
]

npm_packages=%w[
  yo
  generator-hubot
  grunt-cli
  mocha
  chai
  hubot-mock-adapter
  coffee-script
  sinon
]

yum_packages.each do |pkg|
  package pkg do
    action :install
  end
end

npm_packages.each do |npm|
  bash "npm install #{npm}" do
    user "root"
    cwd "/tmp"
    code <<-EOH
      npm install -g #{npm}
    EOH
  end
end
