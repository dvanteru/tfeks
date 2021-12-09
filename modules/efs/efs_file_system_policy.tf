# resource "aws_efs_file_system_policy" "policy" {
#   file_system_id = aws_efs_file_system.main.id

#   policy = data.aws_iam_policy_document.efs_filesystem.json
# }
