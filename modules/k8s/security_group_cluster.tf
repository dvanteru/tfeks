resource "aws_security_group" "cluster" {
  name = "${local.csi}-ctrl"

  description = "Security group for ${local.csi} control plane"
  vpc_id      = var.vpc_id
  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-ctrl"
    },
  )
}

resource "aws_security_group_rule" "cluster_https_egress" {
  description       = "Allow cluster egress to all for HTTPS"
  protocol          = "tcp"
  security_group_id = aws_security_group.cluster.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  from_port         = 443
  to_port           = 443
  type              = "egress"
}

resource "aws_security_group_rule" "cluster_dynamic_ports_egress" {
  description       = "Allow cluster egress to self for dynamic ports"
  protocol          = "tcp"
  security_group_id = aws_security_group.cluster.id
  self              = true
  from_port         = 1025
  to_port           = 65535
  type              = "egress"
}

resource "aws_security_group_rule" "cluster_https_ingress" {
  description       = "Allow cluster ingress from self for HTTPS"
  protocol          = "tcp"
  security_group_id = aws_security_group.cluster.id
  self              = true
  from_port         = 443
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster_dynamic_ports_ingress" {
  description       = "Allow cluster ingress from self for dynamic ports"
  protocol          = "tcp"
  security_group_id = aws_security_group.cluster.id
  self              = true
  from_port         = 1025
  to_port           = 65535
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster_custom_security_group_https_ingress" {
  count                    = length(var.additional_ingress_security_groups)
  description              = "Allow cluster ingress from additional security groups for HTTPS"
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = var.additional_ingress_security_groups[count.index]
  from_port                = 443
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_custom_cidr_block_https_ingress" {
  count                    = length(var.additional_ingress_cidrs) >= 1 ? 1 : 0
  description              = "Allow cluster ingress from additional cidr blocks for HTTPS"
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster.id
  cidr_blocks              = var.additional_ingress_cidrs
  from_port                = 443
  to_port                  = 443
  type                     = "ingress"
}
