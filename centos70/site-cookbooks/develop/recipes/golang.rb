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
    execute "exec GOOS=#{goos} goarch=#{goarch} ./make.bash" do
      command <<-EOF
        cd #{golang[:GOROOT]}/src
        GOOS=#{goos} GOARCH=#{goarch} ./make.bash
      EOF
    end
  end
end

golang[:tools].each do |tool|
  execute "install #{tool}" do
    command <<-EOF
      GOPATH=#{node[:develop][:home]}/.go #{golang[:GOROOT]}/bin/go get #{tool}
    EOF
  end
end
