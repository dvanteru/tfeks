module "s3_jenkinsbackup" {
  source = "../../modules/s3"

  project                        = var.project
  environment                    = var.environment
  component                      = var.component
  aws_account_id                 = var.aws_account_id
  region                         = var.region
  acl                            = "private"
  bucket_suffix                  = "jenkinsbackup"
  vpc_id                         = data.aws_vpc.main.id
  attach_elb_log_delivery_policy = false

  logging = {
    target_bucket = module.s3_log_bucket.bucket_id
    target_prefix = "log/"
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm     = "aws:kms"
      }
    }
  }
}