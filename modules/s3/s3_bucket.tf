resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name
  acl    = var.acl

  force_destroy = "false"

  lifecycle_rule {
    prefix  = ""
    enabled = "true"

    noncurrent_version_transition {
      days          = "30"
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = "60"
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = "90"
    }
  }

  dynamic "website" {
    for_each = length(keys(var.website)) == 0 ? [] : [var.website]

    content {
      index_document           = lookup(website.value, "index_document", null)
      error_document           = lookup(website.value, "error_document", null)
      redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null)
      routing_rules            = lookup(website.value, "routing_rules", null)
    }
  }

  dynamic "logging" {
    for_each = length(keys(var.logging)) == 0 ? [] : [var.logging]

    content {
      target_bucket = lookup(logging.value, "target_bucket", null)
      target_prefix = "${lookup(logging.value, "target_prefix", null)}${local.bucket_name}"
    }
  }

  dynamic "cors_rule" {
    for_each = var.cors_rule

    content {
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      allowed_headers = lookup(cors_rule.value, "allowed_headers", null)
      expose_headers  = lookup(cors_rule.value, "expose_headers", null)
      max_age_seconds = lookup(cors_rule.value, "max_age_seconds", null)
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = length(keys(var.server_side_encryption_configuration)) == 0 ? [] : [var.server_side_encryption_configuration]
    content {
      dynamic "rule" {
        for_each = length(keys(lookup(server_side_encryption_configuration.value, "rule", {}))) == 0 ? [] :
                   [lookup(server_side_encryption_configuration.value, "rule", {})]
        content {
          dynamic "apply_server_side_encryption_by_default" {
            for_each = length(keys(lookup(rule.value, "apply_server_side_encryption_by_default", {}))) == 0 ? [] : [
                         lookup(rule.value, "apply_server_side_encryption_by_default", {})]
            content {
              sse_algorithm     = apply_server_side_encryption_by_default.value.sse_algorithm
              kms_master_key_id = module.kms.key_arn
            }
          }
        }
      }
    }
  }


  versioning {
    enabled = "true"
  }

  tags = merge(
    local.default_tags,
    {
      Name = local.csi
    }
  )
}

