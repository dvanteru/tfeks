resource "aws_eks_node_group" "node_groups" {
  for_each = var.node_groups

  cluster_name       = local.csi
  node_group_name    = "${local.csi}-ng-spt-${each.key}"
  node_role_arn      = aws_iam_role.node_group.arn
  subnet_ids         = module.subnets_worker_nodes.subnet_ids

  capacity_type = each.value.capacity_type

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  launch_template {
    id            = aws_launch_template.eks_node_launch_template.id #[each.key].id
    #disk_size     = each.value.disk_size
    version       = "$Latest"
  }

  instance_types = each.value.instance_types

  tags = local.default_tags

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node_group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_group-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node_group-ECRAccess,
    null_resource.wait_for_cluster,
  ]
}