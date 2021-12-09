output "pipeline_csi" {
  value = "${var.tfp_project}-${var.tfp_environment}-${var.tfp_component}"
}

output "pipeline_group" {
  value = var.tfp_group
}

output "codepipeline" {
  value = aws_codepipeline.main
}
