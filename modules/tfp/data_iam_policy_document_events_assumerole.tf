data "aws_iam_policy_document" "events_assumerole" {
  count = var.tfp_schedule == "" ? 0 : 1

  statement {
    sid    = "EventsAssumeRole"
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "events.amazonaws.com",
      ]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}
