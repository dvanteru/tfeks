# Create the Key Policy for the AWS KMS Key
resource "aws_iam_policy" "admin" {
  name   = "${local.csi}-admin"
  path   = "/"
  policy = data.aws_iam_policy_document.admin.json
}

