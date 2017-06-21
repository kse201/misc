bind_addr = "0.0.0.0"

name = "node-1"

region = "local"

datacenter = "dc1"

log_level = "DEBUG"

data_dir = "/var/lib/nomad"

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
