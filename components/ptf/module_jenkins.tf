module "jenkins" {
  source = "../../modules/jenkins"

  project            = var.project
  environment        = var.environment
  component          = var.component
  aws_account_id     = var.aws_account_id
  region             = var.region
  jenkins_version    = "2.263.1"
  port               = "8080"
  namespace          = "default"
  chart_release      = "3.1.2"
  domain             = var.route_53_zone_name
  jenkins_image_path = var.jenkins_image_path
  jenkins_image_tag  = var.jenkins_image_tag
  efs_volume_handle  = module.efs_jenkins.efs_filesystem_id
  name               = "ptf-jenkins"
  volume_size        = "100"
  depends_on = [
    module.eks
  ]
}
