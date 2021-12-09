data "aws_iam_policy_document" "control_plane_kms" {
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
}

