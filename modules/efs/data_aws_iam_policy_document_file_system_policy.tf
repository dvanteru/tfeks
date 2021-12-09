data "aws_iam_policy_document" "efs_filesystem" {
  statement {
    sid    = "ReadWriteAccess"
    effect = "Allow"

    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite"
    ]

    resources = [
      aws_efs_file_system.main.arn,
    ]

    principals {
      type = "AWS"

      identifiers = var.iam_roles_read_write_access
    }
  }

  statement {
    sid    = "ReadOnlyAccess"
    effect = "Allow"

    actions = [
      "elasticfilesystem:ClientMount",
    ]

    resources = [
      aws_efs_file_system.main.arn,
    ]

    principals {
      type = "AWS"

      identifiers = var.iam_roles_read_only_access
    }
  }
}
