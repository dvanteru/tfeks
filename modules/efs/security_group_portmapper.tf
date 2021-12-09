resource "aws_security_group" "portmapper" {
  name = "${local.csi}-portmapper"

  description = "Security group for ${local.csi} mount points"
  vpc_id      = var.vpc_id
  tags = merge(
  local.default_tags,
  {
    Name = "${local.csi}-portmapper"
  },
  )
}

resource "aws_security_group_rule" "security_group_ingress_portmapper_tcp" {
  count                    = length(var.allowed_security_groups)
  description              = "Allow portmapper ingress from additional security groups for EFS"
  protocol                 = "tcp"
  security_group_id        = aws_security_group.portmapper.id
  source_security_group_id = var.allowed_security_groups[count.index]
  from_port                = 111
  to_port                  = 111
  type                     = "ingress"
}

resource "aws_security_group_rule" "cidr_block_ingress_portmapper_tcp" {
  count                    = length(var.allowed_cidrs) >= 1 ? 1 : 0
  description              = "Allow portmapper ingress from additional CIDRs for EFS"
  protocol                 = "tcp"
  security_group_id        = aws_security_group.portmapper.id
  cidr_blocks              = var.allowed_cidrs
  from_port                = 111
  to_port                  = 111
  type                     = "ingress"
}

resource "aws_security_group_rule" "security_group_ingress_portmapper_udp" {
  count                    = length(var.allowed_security_groups)
  description              = "Allow portmapper ingress from additional security groups for EFS"
  protocol                 = "udp"
  security_group_id        = aws_security_group.portmapper.id
  source_security_group_id = var.allowed_security_groups[count.index]
  from_port                = 111
  to_port                  = 111
  type                     = "ingress"
}

resource "aws_security_group_rule" "cidr_block_ingress_portmapper_udp" {
  count                    = length(var.allowed_cidrs) >= 1 ? 1 : 0
  description              = "Allow portmapper ingress from additional CIDRs for EFS"
  protocol                 = "udp"
  security_group_id        = aws_security_group.portmapper.id
  cidr_blocks              = var.allowed_cidrs
  from_port                = 111
  to_port                  = 111
  type                     = "ingress"
}
