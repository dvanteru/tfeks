resource "aws_cloudwatch_event_rule" "main" {
  count               = var.tfp_schedule == "" ? 0 : 1
  name                = local.csi
  description         = local.csi
  schedule_expression = var.tfp_schedule
  is_enabled          = true
}
