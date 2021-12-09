data "aws_iam_policy_document" "node_ebs_kms" {
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
    sid    = "AllowEC2Access"
    effect = "Allow"

    actions = [
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Encrypt",
      "kms:DescribeKey",
      "kms:Decrypt"
    ]

    resources = [
      "*",
    ]

    principals {
      type = "Service"
      identifiers = [
      "ec2.amazonaws.com"]
    }

  }

  statement {
    sid    = "AllowEC2AutoscallingKMSAccess"
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = [
      "*",
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.aws_account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling",
        aws_iam_service_linked_role.autoscaling.arn
      ]
    }

  }

  statement {
    sid    = "AllowEC2AutoscallingKMSGrant"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.aws_account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling",
        aws_iam_service_linked_role.autoscaling.arn
      ]
    }

    actions = [
      "kms:CreateGrant"
    ]

    resources = [
      "*",
    ]

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values = [
        "true"
      ]
    }
  }

  depends_on = [
    aws_iam_role.cluster_autoscaler
  ]
}