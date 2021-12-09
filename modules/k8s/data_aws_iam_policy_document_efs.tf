# data "aws_iam_policy_document" "efs" {
#   statement {
#     sid    = "ReadWriteAccess"
#     effect = "Allow"

#     actions = [
#       "elasticfilesystem:ClientMount",
#       "elasticfilesystem:ClientWrite"
#     ]

#     resources = [
#       module.efs[0].efs_filesystem_arn,
#     ]
#   }
# }
