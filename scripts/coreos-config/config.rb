#!/usr/bin/ruby
require 'open-uri'
require 'yaml'

cloud_fn = 'cloud-config.yml'
if File.exist? cloud_fn
  data = YAML.load_file(cloud_fn)
else
  data = {
    'coreos' => {
    }
  }
end

if data.key? 'coreos'
  if data['coreos'].key?('etcd') || data['coreos'].key?('etcd2')
    num_instances = 1
    new_discovery_url = "http://discovery.etcd.io/new?size=#{num_instances}"

    require 'open-uri'
    param = if ENV['http_proxy']
              require 'uri'
              proxy = URI.parse(ENV['http_proxy'])
              { proxy_http_basic_authentication: \
                ["#{proxy.scheme}://#{proxy.host}:#{proxy.port}",
                 URI.decode(proxy.user), proxy.password] }
            end
    token = open(new_discovery_url, param).read

    if data['coreos'].key? 'etcd'
      etcd = data['coreos']['etcd']
    else
      etcd = data['coreos']['etcd2']
    end

    etcd['discovery'] = token
    etcd['discovery-proxy'] = \
      ENV['http_proxy'] if ENV['http_proxy']
  end

  # Fix for YAML.load() converting reboot-strategy from 'off' to `false`
  data['coreos']['update']['reboot-strategy'] = 'off' \
    if data['coreos'].key?('update') && \
       data['coreos']['update'].key?('reboot-strategy') && \
       data['coreos']['update']['reboot-strategy'] == false

  data['coreos']['units'] = Dir.glob('./units/*').map do |unit_dir|
    unit = Dir.glob("#{unit_dir}/*").find { |f| FileTest.file?(f) }
    drop_ins = Dir.glob("#{unit_dir}/drop-ins/*")
    u = {
      'name' => File.basename(unit),
      'command' => 'start',
      'enable' => true
    }
    u['content'] = open(unit).read unless open(unit).read.empty?
    u['drop-ins'] = drop_ins.map do |d|
      {
        'name' => File.basename(d),
        'content' => open(d).read
      }
    end unless drop_ins.empty?
    u
  end
end

data['write_files'] = Dir.glob('./files/**/*').select \
  { |p| FileTest.file?(p) }.map do |file|
  {
    'path' => file.sub('./files', ''),
    'content' => open(file).read
  }
end

File.open(cloud_fn, 'w') do |file|
  file.write("#cloud-config\n\n#{YAML.dump(data)}")
end
# vim : set shiftwidth=2 :
