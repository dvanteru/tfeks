data "aws_iam_policy_document" "control_plane_elb_service_linked_role_creation" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeInternetGateways"
    ]
    resources = ["*"]
  }
}