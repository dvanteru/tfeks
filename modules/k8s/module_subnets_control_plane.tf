module "subnets_control_plane" {
  source = "../../modules/subnets"

  project     = var.project
  environment = var.environment
  component   = var.component
  name        = "${local.csi}-ctrl"

  availability_zones = data.aws_availability_zones.available.names
  cidrs              = local.control_plane_subnet_cidrs
  route_tables       = [ var.control_plane_subnets.route_table_id ]
  vpc_id             = var.vpc_id

  default_tags = merge(
    local.default_tags,
    {
      "kubernetes.io/cluster/${local.csi}" = "shared"
    }
  )
}