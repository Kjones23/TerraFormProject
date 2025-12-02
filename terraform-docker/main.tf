terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

module "network" {
  source = "./modules/network"
  network_name = var.network_name
}

module "database" {
  source       = "./modules/database"
  db_user      = var.db_user
  db_password  = var.db_password
  db_name      = var.db_name
  network_name = var.network_name
}

module "backend" {
  source       = "./modules/backend"
  network_name = var.network_name
}

module "frontend" {
  source       = "./modules/frontend"
  network_name = var.network_name
  backend_url  = "http://backend:8081"
}
