job "wordpress" {
  datacenters = ["dc1"]
  type        = "service"

  group "app" {
    task "wordpress" {
      driver = "docker"

      config {
        image = "wordpress"

        port_map {
          "http" = 80
        }
      }

      resources {
        cpu    = 50
        memory = 1024

        network {
          port "http" {}
        }
      }

      env {
        WORDPRESS_DB_PASSWORD = "example"
        WORDPRESS_DB_HOST     = "mysql.service.consul"
      }

      service {
        name = "wordpress"
        port = "http"
        tags = ["background"]

        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "5s"
        }
      }
    }
  }

  group "db" {
    task "mysql" {
      driver = "docker"

      config {
        image = "mysql:5.7"

        port_map {
          "db" = 3306
        }
      }

      env {
        MYSQL_ROOT_PASSWORD = "example"
      }

      resources {
        memory = 1024

        network {
          port "db" {}
        }
      }

      service {
        name = "mysql"
        port = "db"

        check {
          type     = "tcp"
          port     = "db"
          interval = "10s"
          timeout  = "5s"
        }
      }
    }
  }
}
