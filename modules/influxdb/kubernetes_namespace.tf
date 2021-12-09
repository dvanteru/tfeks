resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = var.namespace
  }
}
