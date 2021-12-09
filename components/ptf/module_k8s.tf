module "eks" {
  source = "../../modules/k8s"

  project         = var.project
  environment     = var.environment
  component       = var.component
  aws_account_id  = var.aws_account_id
  region          = var.region
  cluster_version = "1.18"

  vpc_id   = data.aws_vpc.main.id
  vpc_cidr = var.vpc_cidr

  additional_ingress_cidrs = [
  "10.1.96.0/20"]
  aws_auth_map_additional_users = var.aws_auth_map_additional_users
  aws_auth_map_additional_roles = var.aws_auth_map_additional_roles

  control_plane_subnets = {
    subnets_newbits     = tonumber(split(",", var.subnets.control)[0])
    subnets_netnum_root = tonumber(split(",", var.subnets.control)[1])
    route_table_id      = data.aws_route_table.transit.id
  }

  worker_node_subnets = {
    subnets_newbits     = tonumber(split(",", var.subnets.worker)[0])
    subnets_netnum_root = tonumber(split(",", var.subnets.worker)[1])
    route_table_id      = data.aws_route_table.transit.id
  }

  private_lb_subnets = {
    subnets_newbits     = tonumber(split(",", var.subnets.lb)[0])
    subnets_netnum_root = tonumber(split(",", var.subnets.lb)[1])
    route_table_id      = data.aws_route_table.transit.id
  }

  deploy_aws_load_balancer_controller = true
  deploy_external_dns                 = true
}
