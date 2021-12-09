resource "aws_route53_delegation_set" "subdomain" {
  reference_name = "${var.subdomain}.${var.tld_internal_name}"
}

