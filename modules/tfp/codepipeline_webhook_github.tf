resource "aws_codepipeline_webhook" "github" {
  count = var.tfp_webhook ? 1 : 0

  name            = "${local.csi}-github"
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = aws_codepipeline.main.name

  authentication_configuration {
    secret_token = data.aws_ssm_parameter.github_pat.value
  }

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/{Branch}"
  }
}
