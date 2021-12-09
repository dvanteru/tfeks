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
  default     = "jenkins"
}

variable "name" {
  type        = string
  description = "A unique name to distinguish this module invocation from others within the same CSI scope"
  default     = "jenkins-halo"
}

variable "jenkins_version"{
  type        = string
  description = "The version of jenkins to be deployed"

}

variable "namespace"{
  type        = string
  description = "The namespace of jenkins to be deployed"
}

variable "port" {
  type        = string
  description = "The port of jenkins to be deployed"
}

variable "service_name" {
  type        = string
  description = "The name of the service in K8s"
  default     = "jenkins"
}

variable "chart_release" {
  type        = string
  description = "Helm chart release version"
}

variable "volume_size"{
  type        = string
  description = "Size of the Jenkins volume"
  default     = "10Gi"
}

variable "domain" {
  type        = string
  description = "Route53 zone"
}

variable "efs_volume_handle" {
  type        = string
  description = "The ID of the EFS volume"

}

variable "healthcheck_path" {
  type        = string
  description = "Path to use for the health check"
  default     = "/login"
}

variable "adminPassword" {
  type    = string
  default = "Passw0rd1"
}

variable "jenkins_image_path" {
  type    = string
  default = ""
}

variable "jenkins_image_tag" {
  type    = string
  default = ""
}



