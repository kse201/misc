bind_addr = "0.0.0.0"

name = "node-1"

region = "local"

datacenter = "dc1"

enable_syslog = true
enable_debug = true

log_level = "DEBUG"

data_dir = "/var/lib/nomad"

advertise {
  http = ""
  rpc  = ""
  serf = ":5648"
}

server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled = true

  options = {
    "driver.raw_exec.enable" = "1"
  }
}
