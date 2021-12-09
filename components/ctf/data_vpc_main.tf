data "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  
  filter {
    name   = "tag:Project"
    values = [ "halo" ]
  }

  filter {
    name   = "tag:Module"
    values = [ "avm-vpc" ]
  }
}
