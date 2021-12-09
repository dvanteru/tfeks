data "aws_iam_policy_document" "control_plane_cloudwatch_log_group_kms" {
  statement {
    sid    = "AllowFullLocalAdministration"
    effect = "Allow"

    actions = [
      "kms:*",
    ]

    resources = [
      "*",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${var.aws_account_id}:root",
      ]
    }
  }

  statement {
    sid    = "AllowCloudWatchLogsKeyUsage"
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "logs.${var.region}.amazonaws.com",
      ]
    }
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = [
      "*",
    ]
    condition {
      test = "ArnEquals"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values = [
        "arn:aws:logs:${var.region}:${var.aws_account_id}:log-group:/aws/eks/${local.csi}/cluster",
      ]
    }  
  }
}

