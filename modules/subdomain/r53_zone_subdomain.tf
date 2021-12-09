resource "aws_route53_zone" "subdomain" {
  name              = "${var.subdomain}.${var.parent_domain_name}."
  comment           = "${var.subdomain} Subdomain of Hosted Zone ${var.parent_zone_id} ${var.parent_domain_name}"
  #delegation_set_id = aws_route53_delegation_set.subdomain.id
  force_destroy     = var.force_destroy
  tags              = var.tags

  vpc {
    vpc_id = var.vpc_id
  }
}

