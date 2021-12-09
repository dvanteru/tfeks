resource "kubernetes_cluster_role_binding" "cluster_autoscaler" {
  metadata {
    labels    = {
      "k8s-addon" = "cluster-autoscaler.addons.k8s.io"
      "k8s-app"   = "cluster-autoscaler"
    }
    name      = "cluster-autoscaler"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.cluster_autoscaler.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.cluster_autoscaler.metadata.0.name
    namespace = "kube-system"
  }
}