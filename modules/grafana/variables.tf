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

variable "region" {
  type        = string
  description = "AWS region to deploy into"
}

variable "aws_account_id" {
  type        = string
  description ="AWS account ID"
}

variable "module" {
  type        = string
  description = "The name of this module. This is a special variable, it should be set only here and never overridden."
  default     = "grafana"
}

variable "name" {
  type        = string
  description = "A unique name to distinguish this module invocation from others within the same CSI scope"
  default     = "grafana-halo"
}

variable "namespace"{
  type        = string
  description = "The namespace of grafana to be deployed"
}

variable "port" {
  type        = string
  description = "The port of grafana to be deployed"
}

variable "service_name" {
  type        = string
  description = "The name of the service in K8s"
  default     = "grafana"
}

variable "domain" {
  type        = string
  description = "Route53 zone"
}

variable "healthcheck_path" {
  type        = string
  description = "Path to use for the health check"
  default     = "/login"
}