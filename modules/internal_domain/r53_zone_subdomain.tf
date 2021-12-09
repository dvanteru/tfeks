resource "aws_route53_zone" "subdomain" {
  name              = "${var.subdomain}.${var.tld_internal_name}."
  comment           = "${var.subdomain} Internal domain name"
  force_destroy     = var.force_destroy
  tags              = var.tags

  vpc {
    vpc_id = var.vpc_id
  }
}

