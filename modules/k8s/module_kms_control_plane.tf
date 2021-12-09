module "control_plane_kms" {
  source = "../../modules/kms"

  project     = var.project
  environment = var.environment
  component   = var.component

  alias           = "alias/${local.csi}/ctrl"
  deletion_window = "30"
  name            = "${local.csi}-ctrl"

  key_policy_document = data.aws_iam_policy_document.control_plane_kms.json
}