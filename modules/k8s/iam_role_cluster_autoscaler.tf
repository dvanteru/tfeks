resource "aws_iam_role" "cluster_autoscaler" {
  name                  = "${local.csi}-cluster-as"
  force_detach_policies = true
  assume_role_policy    = data.aws_iam_policy_document.cluster_autoscaler_assume_role.json
  tags                  = local.default_tags
}

resource "aws_iam_policy" "cluster_autoscaler" {
  name        = "${local.csi}-cluster-as"
  description = "EKS cluster-autoscaler policy for cluster ${local.csi}"
  policy      = data.aws_iam_policy_document.cluster_autoscaler.json
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
  policy_arn = aws_iam_policy.cluster_autoscaler.arn
  role       = aws_iam_role.cluster_autoscaler.name
}