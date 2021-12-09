resource "aws_iam_role" "node_group" {
  name                  = "${local.csi}-ng"
  force_detach_policies = true
  assume_role_policy    = data.aws_iam_policy_document.node_group_assume_role.json
  tags                  = local.default_tags
}

# resource "aws_iam_policy" "node_group_efs_readwrite" {
#   name        = "${local.csi}-wrk-efs-rw"
#   description = "Permission for ${local.csi} read/write EFS access from worker nodes"
#   policy      = data.aws_iam_policy_document.efs.json
# }

resource "aws_iam_role_policy_attachment" "node_group-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "node_group-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "node_group-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "node_group-SecretsManagerReadWrite" {
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "node_group-CloudWatchLogsFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "node_group-ECRAccess" {
  policy_arn = aws_iam_policy.ecr_policy.arn
  role       = aws_iam_role.node_group.name
}

# resource "aws_iam_role_policy_attachment" "node_group_efs_readwrite" {
#   policy_arn = aws_iam_policy.node_group_efs_readwrite.arn
#   role       = aws_iam_role.node_group.name
# }
