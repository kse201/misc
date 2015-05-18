#
# Cookbook Name:: develop
# Recipe:: golang
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

golang = node[:develop][:golang]

package "mercurial" do
  action :install
end

execute "install go" do
  command <<-EOF
    hg clone -u release #{golang[:src]} #{golang[:GOROOT]}
    cd #{golang[:GOROOT]}/src
    ./all.bash
  EOF
end

golang[:GOOS].each do |goos|
  golang[:GOARCH].each do |goarch|
    execute "install #{gols}"
    command <<-EOF
      cd #{golang[:GOROOT]}/src
      GOOS=#{goos} GOARCH=#{goarch} ./make.bash
    EOF
  end
end

golang[:tools].each do |tool|
  execute "install #{tool}"
  command <<-EOF
      GOPATH=#{golang[:GOROOT]} #{golang[:GOROOT]}/bin/go get #{tool}
  EOF
end
