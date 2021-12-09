#resource "kubernetes_storage_class" "ebs" {
#  metadata {
#    name = "gp2"
#  }
#  storage_provisioner = "ebs.csi.aws.com"
#  reclaim_policy      = "Delete"
#}
