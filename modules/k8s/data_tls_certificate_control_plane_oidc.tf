data "tls_certificate" "control_plane_oidc" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}