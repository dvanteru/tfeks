data "aws_iam_policy_document" "cluster_autoscaler_assume_role" {
  statement {
    sid = "IRSAClusterAutoscalerAssumeRole"

    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = [ "arn:aws:iam::${var.aws_account_id}:oidc-provider/${replace(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")}" ]
    }

    condition {
      test = "StringEquals"
      variable = "${replace(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")}:sub" 
      values   = [
        "system:serviceaccount:kube-system:cluster-autoscaler"
      ]
    }
  }
}
