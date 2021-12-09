resource "kubernetes_service_account" "metrics_server" {
  metadata {
    name      = "metrics-server"
    namespace = "kube-system"
  }

  automount_service_account_token = true
}
