output "efs_filesystem_id" {
  value = aws_efs_file_system.main.id
}

output "efs_filesystem_arn" {
  value = aws_efs_file_system.main.arn
}
