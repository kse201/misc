job "docs" {
  datacenters = ["dc1"]
  type        = "batch"

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }

  group "example" {
    task "uptime" {
      driver = "exec"

      config {
        command = "uptime"
      }

      resources {
        cpu = 20
      }
    }
  }
}
