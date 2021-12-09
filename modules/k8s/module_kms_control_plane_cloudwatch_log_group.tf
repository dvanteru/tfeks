module "control_plane_cloudwatch_log_group_kms" {
  source = "../../modules/kms"

  project     = var.project
  environment = var.environment
  component   = var.component

  alias           = "alias/${local.csi}/cloudwatch"
  deletion_window = "30"
  name            = "${local.csi}-cloudwatch"

  key_policy_document = data.aws_iam_policy_document.control_plane_cloudwatch_log_group_kms.json
}