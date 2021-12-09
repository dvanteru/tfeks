resource "kubernetes_role" "cluster_autoscaler" {
  metadata {
    labels    = {
      "k8s-addon" = "cluster-autoscaler.addons.k8s.io"
      "k8s-app"   = "cluster-autoscaler"
    }
    name      = "cluster-autoscaler"
    namespace = "kube-system"
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["create","list","watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["delete", "get", "update", "watch"]
    resource_names = ["cluster-autoscaler-status", "cluster-autoscaler-priority-expander"]
  }
}