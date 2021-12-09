resource "aws_iam_policy" "start_pipeline" {
  count = var.tfp_schedule == "" ? 0 : 1

  name        = "${local.csi}-start-pipeline"
  description = "Pipeline Execution Policy for Scheduled TFP Pipeline ${var.name}"
  policy      = data.aws_iam_policy_document.start_pipeline[0].json
}
