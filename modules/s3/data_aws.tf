# The current AWS identity in use by terraform
data "aws_caller_identity" "current" {
}

data "aws_region" "current" {
}

