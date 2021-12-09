resource "kubernetes_namespace" "nexus" {
  metadata {
    name = var.namespace
  }
}
