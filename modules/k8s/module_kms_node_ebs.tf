module "node_ebs_kms" {
  source = "../../modules/kms"

  project     = var.project
  environment = var.environment
  component   = var.component

  alias           = "alias/${local.csi}/node_ebs"
  deletion_window = "30"
  name            = "${local.csi}-node_ebs"

  key_policy_document = data.aws_iam_policy_document.node_ebs_kms.json
}