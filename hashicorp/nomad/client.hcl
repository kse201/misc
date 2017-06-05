bind_addr = "0.0.0.0"

log_level = "DEBUG"

data_dir = "/tmp/nomad"

advertise {
  http = "127.0.0.1"
  rpc  = "127.0.0.1"
  serf = "127.0.0.1"
}

server {
  enabled          = false
}

client {
    servers =["10.131.232.196:4647"]
  enabled = true

  options {
    "driver.raw_exec.enable" = "1"
  }
}
