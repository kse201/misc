#!/usr/bin/ruby
require 'open-uri'
require 'yaml'

cloud_fn = 'cloud-config.yml'
data = if File.exist?(cloud_fn)
         YAML.load_file(cloud_fn)
       else
         {
           'coreos' => {
           }
         }
       end

if data.key? 'coreos'
  if data['coreos'].key?('etcd') || data['coreos'].key?('etcd2')
    num_instances = 1
    new_discovery_url = "https://discovery.etcd.io/new?size=#{num_instances}"
    token = open(new_discovery_url).read
  end

  data['coreos']['etcd']['discovery'] = token if data['coreos'].key? 'etcd'
  data['coreos']['etcd2']['discovery'] = token if data['coreos'].key? 'etcd2'

  # Fix for YAML.load() converting reboot-strategy from 'off' to `false`
  data['coreos']['update']['reboot-strategy'] = 'off' \
    if data['coreos'].key?('update') \
    && data['coreos']['update'].key?('reboot-strategy') \
    && data['coreos']['update']['reboot-strategy'] == false

  data['coreos']['units'] = Dir.glob('./units/*').map do |unit_fn|
    u = Hash.new
    if md = unit_fn.match(/(.*)\.d$/)
      u['name'] = File.basename md[1]
      u['drop-ins'] = Dir.glob("#{unit_fn}/*").map do |d|
        {
          'name' => File.basename(d),
          'content' => open(d).read
        }
      end
      u
    else
      u['name'] = File.basename(unit_fn)
      u['content'] = open(unit_fn).read unless unit_fn.nil? || unit_fn.empty?

      if u['name'].include? 'service'
        u['command'] = 'start'
        u['enable'] = true
      end

      Dir.glob("#{unit_fn}/*.conf").map do |conf_fn|
        conf = YAML.load_file(conf_fn)
        conf.each do |k, v|
          u[k] = v
        end
      end
      u
    end
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
