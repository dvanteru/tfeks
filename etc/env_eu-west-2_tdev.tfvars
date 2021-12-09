# The tooling development environment in the tooling account...
# This is optional, but not usually required as change does not impact production

environment = "tdev"

ci_terraform_github = {
  organization           = "test-and-trace"
  repo_name              = "myworkload-terraform"
  branch                 = "develop"
  pat_ssm_parameter_name = "/github/terraform"
}

ci_terraform_chatbot = {
  enabled            = false
  slack_channel_id   = ""
  slack_workspace_id = ""
}

ci_terraform_pipelines = [
  { group = "tool", environment = "tdev", component = "ci", gated = true },
]

ci_terraform_docker_image = {
  name    = "run/terraform"
  version = "1.0.0"
}

ci_terraform_subnets = {
  count       = 3
  newbits     = 8
  netnum_root = 0
}

ci_vpc_present = false
