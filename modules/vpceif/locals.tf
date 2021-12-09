locals {
  # Compound Scope Identifier
  csi = replace(
    format("%s-%s-%s", var.project, var.environment, var.component),
    "_",
    "",
  )

  module_instance = replace(
    format(
      "%s-%s-%s-%s-%s",
      var.project,
      var.environment,
      var.component,
      var.module,
      var.service_name,
    ),
    "_",
    "",
  )

  default_tags = merge(
    var.default_tags,
    {
      "Module"      = var.module
      "ServiceName" = var.service_name
    },
  )
}

