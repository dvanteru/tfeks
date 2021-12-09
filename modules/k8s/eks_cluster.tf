resource "aws_eks_cluster" "main" {
  name    = local.csi
  version = var.cluster_version
  
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]

  role_arn = aws_iam_role.control_plane.arn
  
  vpc_config {
    security_group_ids      = [
      aws_security_group.cluster.id
    ]
    subnet_ids              = module.subnets_control_plane.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  encryption_config {
    provider {
      key_arn = module.control_plane_kms.key_arn
    }
    resources = [ "secrets" ]
  }

  timeouts {
    create = "30m"
    delete = "20m"
  }

  depends_on = [
    # Explicitly depend on the CloudWatch Log Group, otherwise the cluster may
    # create the group itself before Terraform and prevent us from managing the
    # settings
    aws_cloudwatch_log_group.control_plane
  ]
}

resource "null_resource" "wait_for_cluster" {
  depends_on = [
    aws_eks_cluster.main,
    aws_security_group_rule.cluster_custom_cidr_block_https_ingress,
    aws_security_group_rule.cluster_custom_security_group_https_ingress,
  ]

  provisioner "local-exec" {
    command     = local.wait_for_cluster_cmd
    interpreter = local.wait_for_cluster_interpreter
    environment = {
      ENDPOINT = aws_eks_cluster.main.endpoint
    }
  }
}
