data "aws_route_table" "transit" {
  vpc_id = data.aws_vpc.main.id
  filter {
    name   = "tag:Name"
    values = [ "halo-${var.account_short_name}-avm-avm-vpc-transit"]
  }
}
