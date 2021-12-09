module "s3_log_bucket" {
  source = "../../modules/s3"

  environment                    = var.environment
  project                        = var.project
  component                      = var.component
  aws_account_id                 = var.aws_account_id
  region                         = var.region
  acl                            = "log-delivery-write"
  bucket_suffix                  = "logs"
  attach_elb_log_delivery_policy = true
  vpc_id                         = data.aws_vpc.main.id
}