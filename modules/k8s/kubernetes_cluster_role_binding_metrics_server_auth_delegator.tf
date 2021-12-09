resource "kubernetes_cluster_role_binding" "metrics_server_auth_delgator" {
  metadata {
    name      = "metrics-server:system:auth-delegator"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "metrics-server"
    namespace = "kube-system"
  }
}
