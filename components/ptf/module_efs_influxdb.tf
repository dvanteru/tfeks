module "efs_influxdb" {
  source = "../../modules/efs"

  project        = var.project
  environment    = var.environment
  component      = var.component
  aws_account_id = var.aws_account_id
  module         = "efs_influxdb"

  root_directory_path  = "/influxdb"
  vpc_id               = data.aws_vpc.main.id
  mount_target_subnets = module.eks.worker_node_subnet_ids
  allowed_security_groups = [
  module.eks.node_group_security_group_id]
}

