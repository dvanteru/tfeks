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

variable "vault_version"{
  type        = string
  description = "The version of vault to be deployed"

}

variable "vault_namespace"{
  type        = string
  description = "The namespace of vault to be deployed"
}

variable "vault_port" {
  type        = string
  description = "The port of vault to be deployed"
}

variable "vault_chart_release" {
  type        = string
  description = "Helm chart release version"
}

variable "healthcheck_path" {
  type        = string
  description = "Path to use for the health check"
  default     = "/"
}

variable "region" {
  type        = string
  description = "AWS region to deploy into"
}

variable "aws_account_id" {
  type        = string
  description ="AWS account ID"
}