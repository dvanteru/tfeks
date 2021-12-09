resource "kubernetes_deployment" "cluster_autoscaler" {
  metadata {
    name      = "cluster-autoscaler"
    namespace = "kube-system"
    labels    = {
      app = "cluster-autoscaler"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "cluster-autoscaler"
      }
    }

    template {
      metadata {
        labels = {
          app = "cluster-autoscaler"
        }
        annotations = {
          "cluster-autoscaler.kubernetes.io/safe-to-evict" = "false"
        }
      }

      spec {
        service_account_name            = kubernetes_service_account.cluster_autoscaler.metadata.0.name
        automount_service_account_token = true

        container {
          name              = "cluster-autoscaler"
          image             = "eu.gcr.io/k8s-artifacts-prod/autoscaling/cluster-autoscaler:v1.18.3"
          image_pull_policy = "Always"
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
          command = [
            "./cluster-autoscaler",
            "--v=4",
            "--stderrthreshold=info",
            "--cloud-provider=aws",
            "--skip-nodes-with-local-storage=false",
            "--expander=least-waste",
            "--balance-similar-node-groups",
            "--skip-nodes-with-system-pods=false",
            "--node-group-auto-discovery=asg:tag=k8s.io/cluster-autoscaler/enabled,k8s.io/cluster-autoscaler/${local.csi}"
          ]
          volume_mount {
            name       = "ssl-certs"
            mount_path = "/etc/ssl/certs/ca-certificates.crt"
            read_only  = true
          }
        }

        volume {
          name = "ssl-certs"
          host_path {
            path = "/etc/ssl/certs/ca-bundle.crt"
          }
        }
      }
    }
  }

  depends_on = [
    # Explicitly wait until we have nodes to deploy the replica set onto
    aws_eks_node_group.node_groups,
  ]
}