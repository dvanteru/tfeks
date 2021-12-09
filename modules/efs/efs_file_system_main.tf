resource "aws_efs_file_system" "main" {
  creation_token = local.csi

  encrypted      = true
  kms_key_id     = module.kms.key_arn

  lifecycle_policy {
    transition_to_ia = "AFTER_90_DAYS"
  }

  tags = merge(
  local.default_tags,
  {
    Name = local.csi
  },
  )
}
