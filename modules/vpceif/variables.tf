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

# We presume this will always be specified. The default of {} will cause an error if a valid map is not specified.
# If we ever want to define this but allow it to not be specified, then we must provide a default tag keypair will be applied
# as the true default. In any other case default_tags should be removed from the module.
variable "default_tags" {
  type        = map(string)
  description = "Default tag map for application to all taggable resources in the module"
  default     = {}
}

##
# Module self-identification
##

variable "module" {
  type        = string
  description = "The name of this module. This is a special variable, it should be set only here and never overridden."
  default     = "vpceif"
}

##
# Variable specific to the module
##

variable "additional_sg_ids" {
  type        = list(string)
  description = "A list of security groups to assign to the endpoint interface in addition to the one created in this module"
  default     = []
}

variable "availability_zones" {
  type        = list(string)
  default     = []
  description = "List of Availability Zones for Subnets"
}

variable "private_dns_enabled" {
  type        = string
  description = "Whether to enable private DNS for the VPC Endpoint"
}

variable "service_name" {
  type        = string
  description = "The name of the service to create an Interface VPC Endpoint for, e.g. kms"
}

variable "subnets_cidrs" {
  type        = list(string)
  default     = []
  description = "List of CIDR blocks for microservice subnets"
}

variable "subnets_route_tables" {
  type        = list(string)
  description = "List of Route table IDs to associate with the subnets. Should almost always be private"
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to attach the endpoint to, and in which to create a security group and subnets"
}

