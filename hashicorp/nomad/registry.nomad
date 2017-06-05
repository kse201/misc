job "registry" {
  datacenters = ["dc1"]

  group "service" {
    task "registry" {
      driver = "docker"

      config {
        image = "registry:latest"
      }

      resources {
        cpu    = 100
        memory = 1024

        network {
          port "http" {
            static = 80
          }

          port "api" {
            static = 5000
          }
        }
      }
    }
  }
}
