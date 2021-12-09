data "aws_iam_policy_document" "start_pipeline" {
  count = var.tfp_schedule == "" ? 0 : 1

  statement {
    sid    = "AllowStartPipelineExecution"
    effect = "Allow"

    actions = [
      "codepipeline:StartPipelineExecution",
    ]

    resources = [
      aws_codepipeline.main.arn,
    ]
  }
}
