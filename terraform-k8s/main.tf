terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "${pathexpand("~/.kube/config")}"
}

module "app" {
  source = "./modules/app"

  app_name       = var.app_name
  image_name     = var.image_name
  container_port = var.container_port
  namespace      = var.namespace
}
