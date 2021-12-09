resource "kubernetes_daemonset" "efs" {
  metadata {
    name      = "efs-csi-node"
    namespace = "kube-system"
  }

  spec {
    selector {
      match_labels = {
        app = "efs-csi-node"
      }
    }

    template {
      metadata {
        labels = {
          app = "efs-csi-node"
        }
      }

      spec {
        node_selector = {
          "kubernetes.io/os"   = "linux"
          "kubernetes.io/arch" = "amd64"
        }
        
        host_network        = true
        priority_class_name = "system-node-critical"
        toleration {
          operator = "Exists"
        }

        container {
          name = "efs-plugin"

          security_context {
            privileged = true
          }

          image = "amazon/aws-efs-csi-driver:v1.0.0"

          args  = [
            "--endpoint=$(CSI_ENDPOINT)",
            "--logtostderr",
            "--v=5",
          ]

          env {
            name  = "CSI_ENDPOINT"
            value = "unix:/csi/csi.sock"
          }

          port {
            container_port = 9809
            host_port      = 9809
            name           = "healthz"
            protocol       = "TCP"
          }

          liveness_probe {
            http_get {
              path     = "/healthz"
              port     = "healthz"
            }
            initial_delay_seconds = 10
            period_seconds        = 2
            failure_threshold     = 5
          }

          

          volume_mount {
            name              = "kubelet-dir"
            mount_path        = "/var/lib/kubelet"
            mount_propagation = "Bidirectional"
          }

          volume_mount {
            name       = "plugin-dir"
            mount_path = "/csi"
          }

          volume_mount {
            name       = "efs-state-dir"
            mount_path = "/var/run/efs"
          }

          volume_mount {
            name       = "efs-utils-config"
            mount_path = "/etc/amazon/efs"
          }
        }

        container {
          name = "csi-driver-registrar"

          image = "quay.io/k8scsi/csi-node-driver-registrar:v1.3.0"

          args = [
            "--csi-address=$(ADDRESS)",
            "--kubelet-registration-path=$(DRIVER_REG_SOCK_PATH)",
            "--v=5",
          ]

          env {
            name  = "ADDRESS"
            value = "/csi/csi.sock"
          }

          env {
            name  = "DRIVER_REG_SOCK_PATH"
            value = "/var/lib/kubelet/plugins/efs.csi.aws.com/csi.sock"
          }

          env {
            name = "KUBE_NODE_NAME"
            value_from {
              field_ref {
                field_path = "spec.nodeName"
              }
            }
          }

          volume_mount {
            name       = "plugin-dir"
            mount_path = "/csi"
          }

          volume_mount {
            name       = "registration-dir"
            mount_path = "/registration"
          }
        }
        
        container {
          name = "liveness-probe"

          image = "quay.io/k8scsi/livenessprobe:v2.0.0"
          args  = [
            "--csi-address=/csi/csi.sock",
            "--health-port=9809",
          ]

          volume_mount {
            name       = "plugin-dir"
            mount_path = "/csi"
          }
        }

        volume {
          name = "kubelet-dir"
          host_path {
            path = "/var/lib/kubelet"
            type = "Directory"
          }
        }

        volume {
          name = "registration-dir"
          host_path {
            path = "/var/lib/kubelet/plugins_registry/"
            type = "Directory"
          }
        }

        volume {
          name = "plugin-dir"
          host_path {
            path = "/var/lib/kubelet/plugins/efs.csi.aws.com/"
            type = "DirectoryOrCreate"
          }
        }

        volume {
          name = "efs-state-dir"
          host_path {
            path = "/var/run/efs"
            type = "DirectoryOrCreate"
          }
        }

        volume {
          name = "efs-utils-config"
          host_path {
            path = "/etc/amazon/efs"
            type = "DirectoryOrCreate"
          }
        }
      }
    }
  }
}
