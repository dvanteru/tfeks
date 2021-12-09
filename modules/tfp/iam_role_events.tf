resource "aws_iam_role" "events" {
  count = var.tfp_schedule == "" ? 0 : 1

  name               = "${local.csi}-events"
  assume_role_policy = data.aws_iam_policy_document.events_assumerole[0].json
}
