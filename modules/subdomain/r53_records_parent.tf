resource "aws_route53_record" "parent_ns" {
  zone_id = var.parent_zone_id
  name    = "${var.subdomain}.${var.parent_domain_name}."
  type    = "NS"
  ttl     = "172800"

  records = aws_route53_delegation_set.subdomain.name_servers
}

