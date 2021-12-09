module "s3_testdata" {
   source = "../../modules/s3"

   project                        = var.project
   environment                    = var.environment
   component                      = var.component
   aws_account_id                 = var.aws_account_id
   region                         = var.region
   acl                            = "private"
   bucket_suffix                  = "testdata"
   vpc_id                         = data.aws_vpc.main.id
   attach_elb_log_delivery_policy = false

   cors_rule = [
      {
         allowed_methods = ["GET", "HEAD"]
         allowed_origins = ["*"]
         allowed_headers = ["*"]
         expose_headers  = ["ETag"]
         max_age_seconds = 3000
      }
   ]

   logging = {
      target_bucket = module.s3_log_bucket.bucket_id
      target_prefix = "log/"
   }
}