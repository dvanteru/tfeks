output cluster_ca_certificate {
  value = base64decode(data.aws_eks_cluster.main.certificate_authority.0.data)
}

output cluster_auth_token {
  value = data.aws_eks_cluster_auth.main.token
}

output cluster_api_endpoint {
  value = data.aws_eks_cluster.main.endpoint
}
