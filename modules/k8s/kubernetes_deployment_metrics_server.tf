resource "kubernetes_deployment" "metrics_server" {
  metadata {
    name      = "metrics-server"
    namespace = "kube-system"
    labels    = {
      "k8s-app" = "metrics-server"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        "k8s-app" = "metrics-server"
      }
    }

    template {
      metadata {
        labels = {
          "k8s-app" = "metrics-server"
        }
      }

      spec {
        service_account_name            = kubernetes_service_account.metrics_server.metadata.0.name
        automount_service_account_token = true

        container {
          name              = "metrics-server"
          image             = "k8s.gcr.io/metrics-server-amd64:v0.3.6"
          image_pull_policy = "IfNotPresent"
          resources {
            limits {
              cpu    = "100m"
              memory = "300Mi"
            }
            requests {
              cpu    = "100m"
              memory = "300Mi"
            }
          }
          args = [
            "--cert-dir=/tmp",
            "--secure-port=4443",
          ]
          volume_mount {
            # mount in tmp so we can safely use from-scratch images and/or read-only containers
            name       = "tmp-dir"
            mount_path = "/tmp"
          }

          port {
            name           = "main-port"
            container_port = 4443
            protocol       = "TCP"
          }

          security_context {
            read_only_root_filesystem = true
            run_as_non_root           = true
            run_as_user               = 1000
          }
        }

        volume {
          name = "tmp-dir"
          empty_dir {}
        }

        node_selector = {
          "kubernetes.io/os"   = "linux"
          "kubernetes.io/arch" = "amd64"
        }
      }
    }
  }

  depends_on = [
    # Explicitly wait until we have nodes to deploy the replica set onto
    aws_eks_node_group.node_groups,
  ]
}
