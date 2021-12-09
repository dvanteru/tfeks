locals {
  # The name of this module. This is a special variable
  module = "grafana"

  # Compound Scope Identifier
  csi = replace(
  format(
  "%s-%s-%s-%s",
  var.project,
  var.environment,
  var.component,
  local.module,
  ),
  "_",
  "-",
  )

  # CSI for resources in the global namespace, e.g. S3 Buckets
  csi_global = replace(
  format(
  "%s-%s-%s-%s-%s-%s",
  var.project,
  var.aws_account_id,
  var.region,
  var.environment,
  var.component,
  local.module,
  ),
  "_",
  "-",
  )

  default_tags = merge(
  var.default_tags,
  {
    Module = local.module
  }
  )
}