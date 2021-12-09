
# AWS Load Balancer access log delivery policy
data "aws_elb_service_account" "this" {
  count = var.attach_elb_log_delivery_policy ? 1 : 0
}

data "aws_iam_policy_document" "elb_log_delivery" {

  statement {
    sid = "AllowALBAccessLogs"

    principals {
      type        = "AWS"
      identifiers = data.aws_elb_service_account.this.*.arn
    }

    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }

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
    sid = "AllowReadFromVPC"
    effect = "Allow"
    actions = [ "s3:GetObject" ]

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