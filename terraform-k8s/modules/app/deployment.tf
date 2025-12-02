resource "kubernetes_deployment" "app" {
  metadata {
    name      = var.app_name
    namespace = var.namespace
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
       container {
  name  = var.app_name
  image = var.image_name
  image_pull_policy = "IfNotPresent"

  port {
    container_port = var.container_port
  }
}

      }
    }
  }
}
