resource "kubernetes_namespace" "grafana" {
  metadata {
    name = var.namespace
  }
}
