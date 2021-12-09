module "influxdb" {
  source = "../../modules/influxdb"

  project           = var.project
  environment       = var.environment
  component         = var.component
  aws_account_id    = var.aws_account_id
  region            = var.region
  port              = "8080"
  namespace         = "influxdb"
  domain            = var.route_53_zone_name
  name              = "ptf-influxdb"
  efs_volume_handle = module.efs_jenkins.efs_filesystem_id
  volume_size       = "30"
  depends_on = [
    module.eks
  ]
}
