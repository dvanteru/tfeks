module "subnets_worker_nodes" {
  source = "../../modules/subnets"

  project     = var.project
  environment = var.environment
  component   = var.component
  name        = "${local.csi}-wrk"

  availability_zones = data.aws_availability_zones.available.names
  cidrs              = local.worker_node_subnet_cidrs
  route_tables       = [ var.worker_node_subnets.route_table_id ]
  vpc_id             = var.vpc_id

  default_tags = merge(
    local.default_tags,
    {
      "kubernetes.io/cluster/${local.csi}" = "shared"
    }
  )
}