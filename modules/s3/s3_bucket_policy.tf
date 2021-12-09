resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = var.attach_elb_log_delivery_policy ? data.aws_iam_policy_document.elb_log_delivery.json : data.aws_iam_policy_document.bucket.json

  depends_on = [ aws_s3_bucket.bucket ]
}