data "aws_iam_policy_document" "control_plane_assume_role" {
  statement {
    sid = "EKSClusterAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = [ "eks.amazonaws.com" ]
    }
  }
}