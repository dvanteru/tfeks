resource "aws_iam_role_policy_attachment" "events_start_pipeline" {
  count = var.tfp_schedule == "" ? 0 : 1

  role       = aws_iam_role.events[0].name
  policy_arn = aws_iam_policy.start_pipeline[0].arn
}
