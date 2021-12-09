resource "kubernetes_cluster_role" "metrics_server" {
  metadata {
    name      = "system:metrics-server"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "nodes", "nodes/stats", "namespaces", "configmaps"]
    verbs      = ["get", "list", "watch"]
  }
}
