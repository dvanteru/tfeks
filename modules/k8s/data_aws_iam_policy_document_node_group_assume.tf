data "aws_iam_policy_document" "node_group_assume_role" {
  statement {
    sid = "EKSNodeGroupAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = [ "ec2.amazonaws.com" ]
    }
  }
}