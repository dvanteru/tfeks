module "kms" {
  source = "../../modules/kms"

  project     = var.project
  environment = var.environment
  component   = var.component

  alias           = "alias/efs/${local.csi}-${var.bucket_suffix}"
  deletion_window = "30"
  name            = "${local.csi}-${var.bucket_suffix}"

  key_policy_document = data.aws_iam_policy_document.kms_s3.json
}

