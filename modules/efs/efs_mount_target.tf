resource "aws_efs_mount_target" "main" {
  count = length(var.mount_target_subnets)

  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = var.mount_target_subnets[count.index]
  security_groups = [aws_security_group.nfs.id, aws_security_group.portmapper.id]
}
