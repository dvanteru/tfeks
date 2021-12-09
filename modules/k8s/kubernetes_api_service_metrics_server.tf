resource "kubernetes_api_service" "metrics_server" {
  metadata {
    name = "v1beta1.metrics.k8s.io"
  }
  spec {
    service {
      name      = "metrics-server"
      namespace = "kube-system"
    }
    group                    = "metrics.k8s.io"
    version                  = "v1beta1"
    insecure_skip_tls_verify = true
    group_priority_minimum   = 100
    version_priority         = 100
  }
}
