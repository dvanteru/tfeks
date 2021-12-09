locals {
  csi = format(
    "%s-%s-%s-%s",
    var.project,
    var.environment,
    var.component,
    var.module
  )

  default_tags = merge(
    var.default_tags,
    {
      Name   = local.csi
      Module = var.module
    },
  )
}
