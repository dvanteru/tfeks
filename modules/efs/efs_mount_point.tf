resource "aws_efs_access_point" "main" {
  file_system_id = aws_efs_file_system.main.id

  root_directory{
    path = var.root_directory_path
    creation_info {
      owner_gid   = var.posix_user_group_id
      owner_uid   = var.posix_user_user_id
      permissions = 777
    }
  }

  posix_user{
    gid = var.posix_user_group_id
    uid = var.posix_user_user_id
  }

  tags = merge(
  local.default_tags,
  {
    Name = local.csi
  },
  )
}
