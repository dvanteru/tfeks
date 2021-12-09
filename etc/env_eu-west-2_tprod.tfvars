# The tooling production environment in the tooling account...

environment = "tprod"

ci_terraform_github = {
  organization           = "test-and-trace"
  repo_name              = "myworkload-terraform"
  branch                 = "master"
  pat_ssm_parameter_name = "/github/terraform"
}

ci_terraform_chatbot = {
  enabled            = false
  slack_channel_id   = ""
  slack_workspace_id = ""
}

ci_terraform_pipelines = [
  { group = "tool", environment = "tprod", component = "ci",   gated = true  },
  { group = "dev",  environment = "dev01", component = "core", gated = true  },
  { group = "test", environment = "int",   component = "core", gated = true  },
  { group = "prod", environment = "prod",  component = "core", gated = true  },
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
