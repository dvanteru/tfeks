resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name = "aws-auth"
    namespace = "kube-system"
    labels    = {
      "app.kubernetes.io/managed-by" = "Terraform"
      "terraform/module"             = local.module
    }
  }

  data = {
        mapRoles    = yamlencode(var.aws_auth_map_additional_roles)
        mapUsers    = yamlencode(var.aws_auth_map_additional_users)
        mapAccounts = yamlencode(var.aws_auth_map_additional_accounts)
  }
  
  depends_on = [
    aws_eks_cluster.main,
  ]
}