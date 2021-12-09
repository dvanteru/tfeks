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
  description = "The AWS Account ID (numeric)"
}

variable "region" {
  type        = string
  description = "The AWS Region"
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

variable "cluster_version" {
  type        = string
  description = "The Kubernetes version"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC the control plane will be created in"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block of the VPC the subnets will be created in"
}

variable "control_plane_subnets" {
  type        = object({
    subnets_newbits     = number
    subnets_netnum_root = number
    route_table_id      = string
  })  
  description = "Newbits and Offset configuration for Control plane subnets in VPC"
  default = {
    subnets_newbits     = 6
    subnets_netnum_root = 0
    route_table_id      = null
  }
}

variable "worker_node_subnets" {
  type        = object({
    subnets_newbits     = number
    subnets_netnum_root = number
    route_table_id      = string
  })
  description = "Newbits and Offset configuration for worker node subnets in VPC"

  default = {
    subnets_newbits     = 6
    subnets_netnum_root = 0
    route_table_id      = null
  }
}

variable "private_lb_subnets" {
  type        = object({
    subnets_newbits     = number
    subnets_netnum_root = number
    route_table_id      = string
  })
  description = "Newbits and Offset configuration for Private Load Balancer subnets in VPC"

  default = {
    subnets_newbits     = 6
    subnets_netnum_root = 0
    route_table_id      = null
  }
}

variable "oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}

variable "node_groups" {
  type        = map(object({
    capacity_type  = string
    desired_size   = number
    max_size       = number
    min_size       = number
    instance_types = list(string)
    disk_size      = number
  }))
  description = "Map of Node Group configuration options"
  default     = {
    on_demand = {
      capacity_type  = "ON_DEMAND",
      desired_size   = 1,
      max_size       = 5,
      min_size       = 1,
      instance_types = [ "m5.xlarge" ],
      disk_size      = 50,
    },

    // spot_1 = {
    //   capacity_type  = "SPOT",
    //   desired_size   = 1,
    //   max_size       = 5,
    //   min_size       = 1,
    //   instance_types = [ "m5.xlarge", "m5d.xlarge", "m5a.xlarge", "m4.xlarge" ],
    //   disk_size      = 50,
    // }

    // spot_2 = {
    //   capacity_type  = "SPOT",
    //   desired_size   = 1,
    //   max_size       = 5,
    //   min_size       = 1,
    //   instance_types = [ "c5.xlarge", "c5d.xlarge", "c5a.xlarge", "c4.xlarge" ],
    //   disk_size      = 50,
    // }
  }
}

variable "aws_auth_map_additional_roles" {
  type        = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  description = "List of additional IAM roles to Kubernetes groups mappings to add to AWS auth config map"
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

variable "additional_ingress_cidrs" {
  type        = list(string)
  description = "List of CIDRs to allow HTTPS ingress to the cluster from"
  default     = []
}

variable "additional_ingress_security_groups" {
  type        = list(string)
  description = "List of security group IDs to allow HTTPS ingress to the cluster from"
  default     = []
}

variable "deploy_aws_load_balancer_controller" {
  type        = bool
  description = "Deploy the AWS Load Balancer Controller for ALB Ingress and NLB Services"
  default     = false
}

variable "deploy_external_dns" {
  type        = bool
  description = "Deploy the External DNS Service to Automatically Create R53 Records"
  default     = false
}
