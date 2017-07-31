job "registry" {
  datacenters = ["dc1"]

  group "service" {
    task "registry" {
      driver = "docker"

      config {
        image = "registry:latest"

        port_map = {
          api = 5000
        }

        network_aliases = ["${NOMAD_TASK_NAME}"]
      }

      resources {
        cpu    = 100
        memory = 2048

        network {
          port "api" {}
        }
      }
    }

    task "registry-frontend" {
      driver = "docker"

      config {
        image = "konradkleine/docker-registry-frontend:v2"

        port_map = {
          http  = 80
          https = 443
        }
      }

      env {
        "ENV_DOCKER_REGISTRY_HOST" = "registry"
        "ENV_DOCKER_REGISTRY_PORT" = 5000
      }

      /*
      service {
        port = "http"

        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }
      */

      resources {
        cpu    = 50
        memory = 1024

        network {
          port "http"{}
          port "https"{}
        }
      }
    }
  }
}
