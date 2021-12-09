data "aws_iam_policy_document" "ecr_access" {
  statement {
    sid = "EKSNodeGroupAccessToECR"

    actions = [
      "ecr:*",
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "ecr_policy" {
  name = "${local.csi}-ecr-access"
  policy = data.aws_iam_policy_document.ecr_access.json
}