bind_addr = "0.0.0.0"

log_level = "DEBUG"

data_dir = "/var/lib/nomad"

advertise {
  http = "127.0.0.1"
  rpc  = "127.0.0.1"
  serf = "127.0.0.1"
}

server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled = true

  options {
    "driver.raw_exec.enable" = "1"
  }
}
