data "aws_route53_zone" "main" {
  name         = "${trimsuffix(var.domain, ".")}."
}
