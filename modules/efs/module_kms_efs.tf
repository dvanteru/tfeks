module "kms" {
  source = "../../modules/kms"

  project     = var.project
  environment = var.environment
  component   = var.component

  alias           = "alias/efs/${local.csi}"
  deletion_window = "30"
  name            = local.csi

  key_policy_document = data.aws_iam_policy_document.kms_efs.json
}

