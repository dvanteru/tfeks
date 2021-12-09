##
# Basic inherited variables for terraformscaffold modules
##

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

variable "aws_account_id" {
  type        = string
  description ="AWS account ID"
}

##
# Module self-identification
##

variable "module" {
  type        = string
  description = "The name of this module. This is a special variable, it should be set only here and never overridden."
  default     = "efs"
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

variable "root_directory_path" {
  type        = string
  description = "The path of the root directory for the filesystem"
  default     = "/"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID in which the filesystem mount targets will be created"
}

variable "mount_target_subnets" {
  type        = list(string)
  description = "List of subnet IDs in which to create mount targets"
}

variable "allowed_security_groups" {
  type        = list(string)
  description = "List of security group IDs which will be allowed access to the filesystem"
  default     = []
}

variable "allowed_cidrs" {
  type        = list(string)
  description = "List of CIDRs which will be allowed access to the filesystem"
  default     = []
}

variable "posix_user_group_id" {
  type        = string
  description = "The group id of the posix user for the filesystem"
  default     = "1000"
}

variable "posix_user_user_id" {
  type        = string
  description = "The user id of the posix user for the filesystem"
  default     = "1000"
}

variable "iam_roles_read_write_access" {
  type        = list
  description = "A list of IAM roles who will be granted read/write access to the filesystem"
  default     = []
}

variable "iam_roles_read_only_access" {
  type        = list
  description = "A list of IAM roles who will be granted read only access to the filesystem"
  default     = []
}

