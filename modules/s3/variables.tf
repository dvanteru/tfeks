variable "project" {
  type        = string
  description = "The name of the terraformscaffold project calling the module"
}

variable "environment" {
  type        = string
  description = "The name of the terraformscaffold environment the module is called for"
}

variable "component" {
  type        = string
  description = "The name of the terraformscaffold component calling this module"
}

variable "region" {
  type        = string
  description = "AWS region to deploy into"
}

variable "aws_account_id" {
  type        = string
  description ="AWS account ID"
}

##
# Variable specific to the module
##

# We presume this will always be specified. The default of {} will cause an error if a valid map is not specified.
# If we ever want to define this but allow it to not be specified, then we must provide a default tag keypair will be applied
# as the true default. In any other case default_tags should be removed from the module.
variable "default_tags" {
  type        = map(string)
  description = "Default tag map for application to all taggable resources in the module"
  default     = {}
}

variable "module" {
  type        = string
  description = "The name of this module."
  default     = "s3"
}

variable "bucket_suffix" {
  type        = string
  description = "The bucket name suffix to use for bucket name."
}

variable "acl" {
  type        = string
  description = "The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private. Conflicts with grant"
}

variable "attach_elb_log_delivery_policy" {
  type        = bool
  description = "If s3 bucket should have ELB log delivery policy attached"
  default     = false
}

variable "logging" {
  description = "Map containing access bucket logging configuration."
  type        = map(string)
  default     = {}
}

variable "website" {
  description = "Map containing static web-site hosting or redirect configuration."
  type        = map(string)
  default     = {}
}

variable "cors_rule" {
  description = "List of maps containing rules for Cross-Origin Resource Sharing."
  type        = any
  default     = []
}

variable "vpc_id" {
  type = string
  description = "VPC Id is required to allow access to buckets"
}

variable "server_side_encryption_configuration" {
  description = "Map containing server-side encryption configuration."
  type        = any
  default     = {}
}