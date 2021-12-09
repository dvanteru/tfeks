output "lambda_function_name" {
  value = local.csi
}

output "lambda_function_arn" {
  value = aws_lambda_function.main.arn
}

output "iam_role_name" {
  value = local.csi
}

output "iam_role_arn" {
  value = aws_iam_role.main.arn
}
