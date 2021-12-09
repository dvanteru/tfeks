resource "aws_lambda_function" "main" {
  description   = var.description
  function_name = local.csi
  filename      = local.archive_path
  role          = aws_iam_role.main.arn
  handler       = "${var.function_module_name}.${var.handler_function_name}"
  runtime       = var.runtime
  publish       = true
  memory_size   = var.memory
  timeout       = var.timeout

  source_code_hash = data.archive_file.main.output_base64sha256

  environment {
    variables = merge(
      {
        REGION = var.region
      },
      var.lambda_env_vars,
    )
  }

  tags = merge(
    local.default_tags,
    {
      Name = local.csi
    },
  )
}
