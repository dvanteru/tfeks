data "aws_iam_policy_document" "kms_s3" {
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
    sid    = "AllowS3ToUse"
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
        "s3.amazonaws.com"
      ]
    }
  }
}
