output "cluster_id" {
  description = "The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready"
  value       = aws_eks_cluster.main.id

  # So that calling plans wait for the cluster to be available before attempting
  # to use it. They will not need to duplicate this null_resource
  depends_on = [null_resource.wait_for_cluster]
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = aws_eks_cluster.main.arn
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = aws_eks_cluster.main.version
}

output "cluster_iam_role_name" {
  description = "IAM role name of the EKS cluster."
  value       = aws_iam_role.control_plane.name
}

output "cluster_iam_role_arn" {
  description = "IAM role ARN of the EKS cluster."
  value       = aws_iam_role.control_plane.arn
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS Control Place"
  value       = aws_security_group.cluster.id
}

output "oidc_issuer" {
  description = "The OpenID Connect Issuer URL"
  value       = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "node_group_security_group_id" {
  description = "Security group ID attached to the EKS workers."
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

output "node_group_iam_role_name" {
  description = "IAM role name of the workers"
  value       = aws_iam_role.node_group.name
}

output "node_group_iam_role_arn" {
  description = "IAM role ARN of the workers"
  value       = aws_iam_role.node_group.arn
}

output cluster_ca_certificate {
  value = base64decode(aws_eks_cluster.main.certificate_authority.0.data)
}

output worker_node_subnet_ids {
  value = module.subnets_worker_nodes.subnet_ids
}

output private_lb_subnet_cidrs{
  value = local.private_lb_subnet_cidrs
}

