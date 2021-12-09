resource "aws_launch_template" "eks_node_launch_template" {
  #for_each = var.node_groups

  name        = "eks_node_launch_template"# -${each.value.capacity_type}"
  #description = "EKS Node launch template ${each.value.capacity_type}"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true

      volume_size = "40" #each.value.disk_size #TODO

      encrypted  = true
      kms_key_id = module.node_ebs_kms.key_arn
    }
  }
}