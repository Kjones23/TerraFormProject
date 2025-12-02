terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

variable "network_name" {}
variable "backend_url" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "frontend" {
  name  = "frontend"
  image = docker_image.nginx.name

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = 80
    external = 8080
  }

  volumes {
    host_path      = "C:/Users/katan/OneDrive/Documents/terraform-docker/nginx.conf"
    container_path = "/etc/nginx/conf.d/default.conf"
  }
}

