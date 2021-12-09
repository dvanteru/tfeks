resource "aws_iam_role_policy" "main" {
  name   = local.csi
  role   = aws_iam_role.main.id
  policy = var.iam_policy_document
}

