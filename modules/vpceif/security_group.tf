resource "aws_security_group" "main" {
  name        = local.module_instance
  description = local.module_instance
  vpc_id      = var.vpc_id

  tags = merge(
    local.default_tags,
    {
      "Name" = local.module_instance
    },
  )
}

