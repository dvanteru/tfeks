module "nexus" {
  source = "../../modules/nexus"

  project               = var.project
  environment           = var.environment
  component             = var.component
  aws_account_id        = var.aws_account_id
  region                = var.region
  nexus_version         = "3.27.0"
  port                  = "8081"
  namespace             = "ctf-nexus"
  chart_release         = "4.2.0"
  domain                = var.route_53_zone_name
  name                  = "ctf-nexus"
  volume_size           = "100"
  efs_volume_handle    = module.efs_nexus.efs_filesystem_id

  depends_on = [
    module.eks
  ]
}