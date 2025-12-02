terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_network" "local" {
  name = var.network_name
}

variable "network_name" {}
