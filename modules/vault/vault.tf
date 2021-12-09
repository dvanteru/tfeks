resource "aws_kms_key" "vault" {
  description             = "Vault Unseal Key"
  deletion_window_in_days = 10
}

data "aws_iam_policy_document" "vault_assume_role" {
  statement {
    sid = "EC2AssumeRole"

    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = [ "arn:aws:iam::${var.aws_account_id}:oidc-provider/${replace(module.eks.oidc_issuer, "https://", "")}" ]
    }

    condition {
      test = "StringEquals"
      variable = "${replace(module.eks.oidc_issuer, "https://", "")}:sub" 
      values   = [
        "system:serviceaccount:default:vault"
      ]
    }
  }
}

data "aws_iam_policy_document" "vault_unseal" {
  statement {
    sid = "VaultKMSUnseal"
    effect = "Allow"
    resources = ["*"]
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey"
    ]
  }
}

resource "aws_iam_role" "vault" {
  name               = "${local.csi}-vault-role"
  assume_role_policy = data.aws_iam_policy_document.vault_assume_role.json
}

resource "aws_iam_role_policy" "vault" {
  name   = "${local.csi}-vault-kms-unseal"
  role   = aws_iam_role.vault.id
  policy = data.aws_iam_policy_document.vault_unseal.json
}

resource "kubernetes_service_account" "vault" {
  metadata {
    name      = "vault-ctf"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.vault.arn
    }
  }

  automount_service_account_token = true
}


