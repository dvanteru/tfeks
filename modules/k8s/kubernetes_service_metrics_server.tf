resource "kubernetes_service" "metrics_server" {
  metadata {
    name      = "metrics-server"
    namespace = "kube-system"
    labels    = {
      "kubernetes.io/name"            = "Metrics-server"
      "kubernetes.io/cluster-service" = "true"
    }
  }
  spec {
    selector = {
      "k8s-app" = "metrics-server"
    }
    port {
      port        = 443
      target_port = "main-port"
      protocol    = "TCP"
    }
  }
}
