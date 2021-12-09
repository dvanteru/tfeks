##
# Basic Required Variables for tfscaffold Components
##

variable "project" {
  type        = string
  description = "The name of the tfscaffold project"
}

variable "environment" {
  type        = string
  description = "The name of the tfscaffold environment"
}

variable "component" {
  type        = string
  description = "The name of the tfscaffold component"
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
# tfscaffold variables specific to this module
##

variable "module" {
  type        = string
  description = "The variable encapsulating the name of this module"
  default     = "tfp"
}

variable "default_tags" {
  type        = map(string)
  description = "A map of default tags to apply to all taggable resources within the component"
  default     = {}
}

##
# Variables specific to this module
##

variable "name" {
  type        = string
  description = "The name of the intance of this module, which should be the CSI being deployed"
}

variable "codebuild_project_name" {
  type        = string
  description = "Name of the AWS CodeBuild Project for Terraform Scaffold invocation"
}

variable "codepipeline_role_arn" {
  type        = string
  description = "ARN of the AWS CodePipeline IAM Role"
}

variable "codepipeline_s3_bucket_id" {
  type        = string
  description = "CodePipeline Artifacts S3 Bucket ID"
}

variable "codepipeline_s3_kms_key_arn" {
  type        = string
  description = "CodePipeline Artifacts S3 KMS Key Arn"
}

variable "github_organization" {
  type        = string
  description = "GitHub Organization owning the Landing Zone Repo"
}

variable "github_repo_name" {
  type        = string
  description = "Name of the Landing Zone GitHub repo"
}

variable "github_branch" {
  type        = string
  description = "Branch of the Landing Zone GitHub repo to use"
  default     = "master"
}

variable "github_pat_ssm_parameter_name" {
  type        = string
  description = "Name of the SSM Parameter Store Parameter containing the GitHub Personal Access Token"
}

variable "tfp_project" {
  type        = string
  description = "The Project variable value for the Pipeline"
}

variable "tfp_environment" {
  type        = string
  description = "The Environment variable value for the Pipeline"
}

variable "tfp_component" {
  type        = string
  description = "The Environment variable value for the Pipeline"
}

variable "tfp_group" {
  type        = string
  description = "The Environment variable value for the Pipeline"
}

variable "tfp_gated" {
  type        = bool
  description = "Whether the Pipeline is one-stage, or two-stage with an approval gate"
}

variable "tfp_webhook" {
  type        = bool
  description = "Whether to create a WebHook for initiating the pipeline from repository changes"
  default     = true
}

variable "tfp_schedule" {
  type        = string
  description = "Optional EventBridge schedule for executing the pipeline"
  default     = ""
}
