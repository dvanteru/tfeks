# Create the Key Policy for the AWS KMS Key
resource "aws_iam_policy" "user" {
  name   = "${local.csi}-user"
  path   = "/"
  policy = data.aws_iam_policy_document.user.json
}

