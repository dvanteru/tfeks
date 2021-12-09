resource "aws_codepipeline" "main" {
  name     = local.csi
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.codepipeline_s3_bucket_id
    type     = "S3"

    encryption_key {
      id   = var.codepipeline_s3_kms_key_arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      # Whenever this CodePipeline Pipeline is updated, this will break due to this bug:
      # https://github.com/hashicorp/terraform-provider-aws/issues/15200#issuecomment-747415056
      # And the resource will need to tainted and replaced.
      configuration = {
        Owner      = var.github_organization
        Repo       = var.github_repo_name
        Branch     = var.github_branch
        OAuthToken = data.aws_ssm_parameter.github_pat.value
      }
    }
  }

  dynamic "stage" {
    for_each = var.tfp_gated ? [1] : []

    content {
      name = "Plan"

      action {
        name             = "Build"
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        input_artifacts  = ["source_output"]
        output_artifacts = ["plan_output"]
        version          = "1"

        configuration = {
          ProjectName = var.codebuild_project_name

          EnvironmentVariables = jsonencode([
            {
              name  = "PROJECT"
              value = var.tfp_project
              type  = "PLAINTEXT"
            },
            {
              name  = "ENVIRONMENT"
              value = var.tfp_environment
              type  = "PLAINTEXT"
            },
            {
              name  = "COMPONENT"
              value = var.tfp_component
              type  = "PLAINTEXT"
            },
            {
              name  = "GROUP"
              value = var.tfp_group
              type  = "PLAINTEXT"
            },
            {
              name  = "ACTION"
              value = "plan"
              type  = "PLAINTEXT"
            }
          ])
        }
      }
    }
  }

  dynamic "stage" {
    for_each = var.tfp_gated ? [1] : []

    content {
      name = "Approve"

      action {
        name     = "Approval"
        category = "Approval"
        owner    = "AWS"
        provider = "Manual"
        version  = "1"

        configuration = {
          #NotificationArn = "${var.approve_sns_arn}"
          CustomData = "Approve Apply of ${var.name}"
          #ExternalEntityLink = "${var.approve_url}"
        }
      }
    }
  }

  stage {
    name = "Apply"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["apply_output"]
      version          = "1"

      configuration = {
        ProjectName = var.codebuild_project_name

        EnvironmentVariables = jsonencode([
          {
            name  = "PROJECT"
            value = var.tfp_project
            type  = "PLAINTEXT"
          },
          {
            name  = "ENVIRONMENT"
            value = var.tfp_environment
            type  = "PLAINTEXT"
          },
          {
            name  = "COMPONENT"
            value = var.tfp_component
            type  = "PLAINTEXT"
          },
          {
            name  = "GROUP"
            value = var.tfp_group
            type  = "PLAINTEXT"
          },
          {
            name  = "ACTION"
            value = "apply"
            type  = "PLAINTEXT"
          }
        ])
      }
    }
  }

  tags = local.default_tags
}

