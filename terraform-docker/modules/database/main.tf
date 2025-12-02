terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

variable "db_user" {}
variable "db_password" {}
variable "db_name" {}
variable "network_name" {}

resource "docker_image" "postgres" {
  name = "postgres:15"
}

resource "docker_container" "postgres" {
  name  = "database"
  image = docker_image.postgres.name

  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}"
  ]

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = 5432
    external = 5432
  }
}
