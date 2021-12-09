resource "kubernetes_cluster_role_binding" "metrics_server" {
  metadata {
    name      = "system:metrics-server"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.metrics_server.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.metrics_server.metadata.0.name
    namespace = kubernetes_service_account.metrics_server.metadata.0.namespace
  }
}
