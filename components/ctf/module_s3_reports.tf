module "s3_reports" {
   source = "../../modules/s3"

   project                        = var.project
   environment                    = var.environment
   component                      = var.component
   aws_account_id                 = var.aws_account_id
   region                         = var.region
   acl                            = "private"
   bucket_suffix                  = "reports"
   vpc_id                         = data.aws_vpc.main.id
   attach_elb_log_delivery_policy = false

   logging = {
      target_bucket = module.s3_log_bucket.bucket_id
      target_prefix = "log/${local.csi}"
   }

   website = {
      index_document = "index.html"
      error_document = "error.html"
      routing_rules = jsonencode([{
         Condition : {
            KeyPrefixEquals : "docs/"
         },
         Redirect : {
            ReplaceKeyPrefixWith : "documents/"
         }
      }])
   }
}