resource "helm_release" "vault" {
  name       = "vault"
  chart      = "vault"
  repository = "https://helm.releases.hashicorp.com"

  values = [
    "${templatefile("${path.module}/templates/vault-values.yaml", {
      account_id = var.aws_account_id,
      region = var.region,
      kms_key_id = aws_kms_key.vault.id,
      iam_role_arn = aws_iam_role.vault.arn
    })}"
  ]
}