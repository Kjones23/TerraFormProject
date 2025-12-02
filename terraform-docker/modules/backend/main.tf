terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

variable "network_name" {}

resource "docker_image" "backend" {
  name = "my-backend"
  build {
    context = "${path.root}/backend-app"
  }
}

resource "docker_container" "backend" {
  name  = "backend"
  image = docker_image.backend.name

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = 5000
    external = 8081
  }
}
