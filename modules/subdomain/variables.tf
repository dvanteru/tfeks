/*

As a sub-resource standardisation module, this module does not
expect to receive any of the standard terraformscaffold variables
for construction. The component or module calling this module will
use those variables to define inputs.

Any merging of additional tags into a default_tags map variable
should be done when calling this module, this module only expects the "tags"
map that is already fully defined, including the
Name, Environment, Component and Module (optional) tags

*/

# Whether to permit terraform to destroy the subdomain
variable "force_destroy" {
  type = string
}

# The domain name of the parent Route53 Zone
variable "parent_domain_name" {
  type = string
}

# The Zone ID of the parent Route53 Zone
variable "parent_zone_id" {
  type = string
}

# The name of the subdomain
variable "subdomain" {
  type = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the subdomain public hosted zone"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "The VPC ID"
}

