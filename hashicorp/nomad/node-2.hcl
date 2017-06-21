bind_addr = "0.0.0.0"

name = "node-2"

region = "local"

datacenter = "dc1"

log_level = "DEBUG"

data_dir = "/var/lib/nomad"

server {
  enabled          = false
}

client {
  enabled = true
  servers = ["node-1:4647"]

  options = {
    "driver.raw_exec.enable" = "1"
  }
}
