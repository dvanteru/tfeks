# resource "aws_ecr_repository" "jenkins" {
#   name                 = "jenkins"
#   image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = true
#   }

#   tags = merge(
#   local.default_tags,
#   {
#     "Name" = local.csi_global
#   }
#   )
# }