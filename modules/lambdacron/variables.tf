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
  default     = "lambdacron"
}

variable "default_tags" {
  type        = map(string)
  description = "A map of default tags to apply to all taggable resources within the component"
  default     = {}
}

##
# Variables specific to this module
##

variable "function_name" {
  type        = string
  description = "Base name of this lambda"
}

variable "function_module_name" {
  type        = string
  description = "The name of the function module as used by the lambda handler, e.g. index or exports"
  default     = "index"
}

variable "function_file_extension" {
  type        = string
  description = "The function source file extension, e.g. js or py"
}

variable "description" {
  type        = string
  description = "Description of the Lambda"
}

variable "handler_function_name" {
  type        = string
  description = "The name of the lambda handler function (passed directly to the Lambda's handler option)"
  default     = "handler"
}

variable "memory" {
  type        = number
  description = "The amount of memory to apply to the created Lambda"
}

variable "timeout" {
  type        = number
  description = "Timeout in seconds of the lambda function invocation"
}

variable "log_retention_in_days" {
  type        = string
  description = "The retention period for the CloudwatchLogs events generated by the lambda function"
}

variable "runtime" {
  type        = string
  description = "The runtime to use for the lambda function"
}

variable "cloudwatch_event_target_input" {
  type        = string
  description = "Optional JSON string to use as constant input for the Cloudwatch Event Target that invokes the lambda if using scheduled events"
  default     = null
}

variable "schedule" {
  type        = string
  description = "The fully qualified Cloudwatch Events schedule for when to run the lambda function, e.g. rate(1 day) or a cron() expression. Default disables all events resources"
  default     = ""
}

variable "iam_policy_document" {
  type        = string
  description = "An IAM Policy Document to grant the lambda function access to the API calls it needs. Should be the 'json' attribute of an aws_iam_policy_document data source"
}

variable "lambda_env_vars" {
  type        = map(string)
  description = "Lambda environment parameters map"
  default     = {}
}

variable "function_source" {
  type        = string
  description = "The source code of the lambda function"
}

