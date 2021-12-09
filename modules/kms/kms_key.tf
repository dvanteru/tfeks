resource "aws_kms_key" "main" {
  description             = local.csi
  deletion_window_in_days = var.deletion_window
  policy                  = var.key_policy_document == "" ? data.aws_iam_policy_document.key.json : var.key_policy_document
  enable_key_rotation     = true
  tags                    = local.default_tags
}

