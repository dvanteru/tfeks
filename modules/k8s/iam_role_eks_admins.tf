resource "aws_iam_role" "eks_admins" {
  name                  = "${local.csi}-admins"
  force_detach_policies = true
  assume_role_policy    = data.aws_iam_policy_document.default_assumerole.json
  tags                  = local.default_tags
}
