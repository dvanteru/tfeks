resource "kubernetes_persistent_volume" "efs" {
  metadata {
    name = "jenkins-efs-pv"
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
        volume_handle = var.efs_volume_handle #module.efs.efs_filesystem_id
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "efs" {
  metadata {
    name       = "${var.service_name}-pvc"
    namespace  = "default"
  }

  spec {
    access_modes       = ["ReadWriteMany"]
    storage_class_name = "aws-efs"

    resources {
      requests = {
        storage = var.volume_size
      }
    }

    volume_name = kubernetes_persistent_volume.efs.metadata[0].name
  }
}
