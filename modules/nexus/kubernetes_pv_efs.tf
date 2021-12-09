resource "kubernetes_persistent_volume" "nexus_efs" {
  metadata {
    name = "nexus-efs-pv"
  }

  spec {
    capacity = {
      storage = var.volume_size
    }

    volume_mode                      = "Filesystem"
    access_modes                     = ["ReadWriteMany"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name               = "aws-efs"

    persistent_volume_source {
      csi {
        driver = "efs.csi.aws.com"
        volume_handle = var.efs_volume_handle
      }
    }
  }

}

resource "kubernetes_persistent_volume_claim" "nexus_efs" {
  metadata {
    name       = "${var.service_name}-pvc"
    namespace  = kubernetes_namespace.nexus.metadata[0].name
  }
  spec {
    access_modes       = ["ReadWriteMany"]
    storage_class_name = "aws-efs"

    resources {
      requests = {
        storage = var.volume_size
      }
    }

    volume_name = kubernetes_persistent_volume.nexus_efs.metadata[0].name
  }
}
