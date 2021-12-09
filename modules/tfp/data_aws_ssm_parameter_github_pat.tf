data "aws_ssm_parameter" "github_pat" {
  name            = var.github_pat_ssm_parameter_name
  with_decryption = true
}
