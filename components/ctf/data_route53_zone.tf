data "aws_route53_zone" "main" {
  name         = "${trimsuffix(var.route_53_zone_name, ".")}."
}
