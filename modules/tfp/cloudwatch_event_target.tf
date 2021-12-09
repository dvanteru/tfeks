resource "aws_cloudwatch_event_target" "main" {
  count     = var.tfp_schedule == "" ? 0 : 1
  arn       = aws_codepipeline.main.arn
  role_arn  = aws_iam_role.events[0].arn
  rule      = aws_cloudwatch_event_rule.main[0].name
  target_id = local.csi
}
