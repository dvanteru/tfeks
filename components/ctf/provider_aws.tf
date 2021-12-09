provider "aws" {
  region  = var.region

  assume_role {
    role_arn     = "arn:aws:iam::${var.aws_account_id}:role/${var.deployment_execution_role_name}"
    session_name = local.csi
    external_id  = var.workload_name
  }

  allowed_account_ids = [
    var.aws_account_id,
  ]
}