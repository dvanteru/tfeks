variable "default_tags" {
  type        = map(string)
  description = "Default tag map for application to all taggable resources in the module"
  default     = {}
}

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

variable "healthcheck_path" {
  type        = string
  description = "URL path to be used for the health LB health check"
  default     = "/"
}

variable "nexus_version" {
  type        = string
  description = "Version of nexus container to be deployed"
}

variable "port"{
  type        = string
  description = "Nexus Port"
  default     = "8080"
}

variable "chart_release"{
  type        = string
  description = ""
}

variable "namespace" {
  type        = string
  description = ""
}

variable "volume_size" {
  type        = string
  description = "Size of the Nexus volume"
  default     = "8"
}

variable "region" {
  type        = string
  description = "AWS region to deploy into"
}

variable "domain" {
  type        = string
  description = "Route53 zone"
}

variable "aws_lb_controller_accounts" {
  type        = map
  description = "The accounts to pull the load balancer ingress controller from"
  default = {
    "cn-northwest-1" = "961992271922"
    "cn-north-1"     = "918309763551"
    "me-south-1"     = "558608220178"
    "eu-south-1"     = "590381155156"
    "ap-east-1"      = "800184023465"
    "af-south-1"     = "877085696533"
    "eu-west-2"      = "602401143452" # default
  }
}

variable "aws_account_id" {
  type = string
  description = "AWS account ID of target account"
}

variable "name" {
  type        = string
  description = "A unique name to distinguish this module invocation from others within the same CSI scope"
  default     = "nexus-halo"
}

variable "module" {
  type        = string
  description = "A unique name to distinguish this module invocation from others within the same CSI scope"
  default     = "nexus"
}

variable "service_name" {
  type        = string
  description = "The name of the service in K8s"
  default     = "nexus"
}

variable "efs_volume_handle" {
  type        = string
  description = "The ID of the EFS volume"

}

