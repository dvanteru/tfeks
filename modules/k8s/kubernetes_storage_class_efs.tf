resource "kubernetes_storage_class" "efs" {
  metadata {
    name = "aws-efs"
  }
  storage_provisioner = "efs.csi.aws.com"
  reclaim_policy      = "Retain"
}
