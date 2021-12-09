resource "aws_iam_role" "control_plane" {
  name                  = "${local.csi}-ctrl"
  force_detach_policies = true
  assume_role_policy    = data.aws_iam_policy_document.control_plane_assume_role.json
  tags                  = local.default_tags
}

resource "aws_iam_policy" "control_plane_elb_service_linked_role_creation" {
  name        = "${local.csi}-ctrl-elb-sl-role-create"
  description = "Permission for ${local.csi} cluster to create AWSServiceRoleForElasticLoadBalancing service-linked role"
  policy      = data.aws_iam_policy_document.control_plane_elb_service_linked_role_creation.json
}

resource "aws_iam_role_policy_attachment" "control_plane_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.control_plane.name
}

resource "aws_iam_role_policy_attachment" "control_plane_AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.control_plane.name
}

resource "aws_iam_role_policy_attachment" "control_plane_AmazonEKSVPCResourceControllerPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.control_plane.name
}

resource "aws_iam_role_policy_attachment" "control_plane_elb_service_linked_role_creation" {
  policy_arn = aws_iam_policy.control_plane_elb_service_linked_role_creation.arn
  role       = aws_iam_role.control_plane.name
}
