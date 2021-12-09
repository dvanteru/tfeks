output "security_group_id" {
  value = aws_security_group.main.id
}

output "security_group_name" {
  value = aws_security_group.main.name
}

output "subnet_ids" {
  value = module.subnets.subnet_ids
}

output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.main.id
}

output "vpc_endpoint_network_interface_ids" {
  value = aws_vpc_endpoint.main.network_interface_ids
}

output "vpc_endpoint_state" {
  value = aws_vpc_endpoint.main.state
}

