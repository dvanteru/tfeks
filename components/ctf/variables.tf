##
# Basic Required Variables for tfscaffold Components
##

variable "tfscaffold_bucket_prefix" {
  type        = string
  description = "The tfscaffold bucket prefix (mostly for constructing remote states)"
}

variable "project" {
  type        = string
  description = "The tfscaffold project"
}

variable "aws_account_id" {
  type        = string
  description = "The AWS Account ID (numeric)"
}

variable "region" {
  type        = string
  description = "The AWS Region"
}

variable "environment" {
  type        = string
  description = "The environment variables are being inherited from"
}

variable "group" {
  type        = string
  description = "The group variables are being inherited from (often synonmous with account short-name)"
  default     = ""
}

##
# tfscaffold variables specific to this component
##

# This is the only primary variable to have its value defined as
# a default within its declaration in this file, because the variables
# purpose is as an identifier unique to this component, rather
# then to the environment from where all other variables come.
variable "component" {
  type        = string
  description = "The variable encapsulating the name of this component"
  default     = "ctf"
}

variable "default_tags" {
  type        = map(string)
  description = "A map of default tags to apply to all taggable resources within the component"
  default     = {}
}

##
# Variable specific to the Halo workload deployment mechanism
##

variable "deployment_execution_role_name" {
  type        = string
  description = "The role name for terraform to assume to perform all deployment actions in a given account. This is determined by the Halo Landing Zone and should not normally be changed."
  default     = "DeploymentExecution"
}

variable "account_short_name" {
  type        = string
  description = "The short name for you AWS account being deployed into"
}

variable "workload_name" {
  type        = string
  description = "The workload name for the project within the Halo platform, as defined in the Halo Landing Zone tooling. This is used as the External ID for the DeploymentExecution role assumption"
}

##
# Variables specific to this Component
##

variable "vpc_cidr" {
  type        = string
  description = "The CIDR for the component VPC"
}

variable "subnets" {
  type        = object({
    control = string
    worker  = string
    lb      = string
  })
  description = "Newbits and Offset configuration for subnets"
  default = null
}

variable "aws_auth_map_additional_roles" {
  type        = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  description = "List of additional IAM role to Kubernetes groups mappings to add to AWS auth config map"
  default     = []
}

variable "aws_auth_map_additional_users" {
  type        = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  description = "List of additional IAM user to Kubernetes groups mappings to add to AWS auth config map"
  default     = []
}

variable "aws_auth_map_additional_accounts" {
  type        = list(string)
  description = "List of additional AWS accounts to add to AWS auth config map"
  default     = []
}

variable "tld_internal_name" {
  type        = string
  description = "Name of parent route53 zone ID"
}

variable "subdomain" {
  type        = string
  description = "Name of the route 53 tooling subdomain"
  default     = "tooling"
}

variable "route_53_zone_name" {
  type        = string
  description = "The R53 domain name"
}
variable "jenkins_image_path" {
  type        = string
  description = "pre-build ECR image"
}

variable "jenkins_image_tag" {
  type        = string
  description = "jenkins image tag"
}