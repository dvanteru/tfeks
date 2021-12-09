data "aws_iam_policy_document" "kms_efs" {
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
    sid    = "AllowEFSToUse"
    effect = "Allow"

    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey*",
    ]

    resources = [
      "*",
    ]

    principals {
      type = "Service"

      identifiers = [
        "elasticfilesystem.amazonaws.com"
      ]
    }
  }
}

