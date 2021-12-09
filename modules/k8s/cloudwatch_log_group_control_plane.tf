resource "aws_cloudwatch_log_group" "control_plane" {
  # The name must be in the format "/aws/eks/<cluster name>/cluster" as EKS
  # will only log to this group and will create it itself if it doesn't exist.
  #
  # We want to manage this group to ensure we can configure the log retention
  # and encryption
  name = "/aws/eks/${local.csi}/cluster"

  retention_in_days = 30
  kms_key_id        = module.control_plane_cloudwatch_log_group_kms.key_arn
  tags              = local.default_tags
}