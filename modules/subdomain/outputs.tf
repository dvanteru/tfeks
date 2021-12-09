# Subdomain Zone ID
output "zone_id" {
  value = aws_route53_zone.subdomain.zone_id
}

# Subdomain Computed FQDN
output "domain_name" {
  value = "${var.subdomain}.${var.parent_domain_name}"
}

# Subdomain Delegation Set ID
output "delegation_set_id" {
  value = aws_route53_delegation_set.subdomain.id
}

# Subdomain Delegation Set Name Servers
output "delegation_set_name_servers" {
  value = aws_route53_delegation_set.subdomain.name_servers
}

