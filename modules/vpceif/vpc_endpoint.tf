resource "aws_vpc_endpoint" "main" {
  service_name = format(
    "%s.%s.%s",
    "com.amazonaws",
    data.aws_region.current.name,
    var.service_name,
  )

  private_dns_enabled = var.private_dns_enabled

  security_group_ids = flatten([
    aws_security_group.main.id,
    var.additional_sg_ids,
  ])

  subnet_ids = module.subnets.subnet_ids

  vpc_endpoint_type = "Interface"
  vpc_id            = var.vpc_id
}

