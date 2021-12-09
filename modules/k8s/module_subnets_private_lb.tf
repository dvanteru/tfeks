module "subnets_private_lb" {
  source = "../../modules/subnets"

  project     = var.project
  environment = var.environment
  component   = var.component
  name        = "${local.csi}-priv-lb"

  availability_zones = data.aws_availability_zones.available.names
  cidrs              = local.private_lb_subnet_cidrs
  route_tables       = [ var.private_lb_subnets.route_table_id ]
  vpc_id             = var.vpc_id

  default_tags = merge(
    local.default_tags,
    {
      "kubernetes.io/cluster/${local.csi}" = "shared"
      "kubernetes.io/role/internal-elb"    = 1
    }
  )
}