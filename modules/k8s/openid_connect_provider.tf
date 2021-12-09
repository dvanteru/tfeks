resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = [ "sts.amazonaws.com" ]
  thumbprint_list = [ data.tls_certificate.control_plane_oidc.certificates[0].sha1_fingerprint ]
  url             = aws_eks_cluster.main.identity.0.oidc.0.issuer
}