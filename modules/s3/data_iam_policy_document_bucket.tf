data "aws_iam_policy_document" "bucket" {
  statement {
    sid    = "AllowEKSAccess"
    effect = "Allow"

    actions = [
      "s3:GetBucketAcl",
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObjectTagging",
      "s3:GetObjectTagging",
      "s3:DeleteObjectTagging",
      "s3:GetLifecycleConfiguration",
      "s3:PutLifecycleConfiguration",
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]

    principals {
      type = "Service"

      identifiers = [
        "eks.amazonaws.com"
      ]
    }
  }

  statement {
    sid = "AllowReadWriteFromVPC"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",]

    principals {
      type = "*"
      identifiers = ["*"]
    }

    condition {
      test = "StringEquals"
      values = [
        var.vpc_id
      ]
      variable = "aws:sourceVpc"
    }
  }

  statement {
    sid    = "DontAllowNonSecureConnection"
    effect = "Deny"

    actions = [
      "s3:*",
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "*",
      ]
    }

    condition {
      test = "Bool"
      variable = "aws:SecureTransport"

      values = [
        "false",
      ]
    }
  }
}

