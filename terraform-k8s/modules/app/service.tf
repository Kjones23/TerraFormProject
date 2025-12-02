resource "kubernetes_service" "app" {
  metadata {
    name      = var.app_name
    namespace = var.namespace
  }

  spec {
    selector = {
      app = var.app_name
    }

    port {
      port        = var.container_port
      target_port = var.container_port
    }

    type = "LoadBalancer"
  }
}
