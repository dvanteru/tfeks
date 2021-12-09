module "grafana" {
  source = "../../modules/grafana"

  project        = var.project
  environment    = var.environment
  component      = var.component
  aws_account_id = var.aws_account_id
  region         = var.region
  port           = "8080"
  namespace      = "grafana"
  domain         = var.route_53_zone_name
  service_name   = "ptf-grafana"
  name           = "ptf-grafana"

  depends_on = [
    module.eks
  ]
}
