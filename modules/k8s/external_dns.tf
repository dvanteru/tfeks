data "aws_iam_policy_document" "external_dns" {
  count = var.deploy_external_dns ? 1 : 0

  statement {
    effect = "Allow"

    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "route53:ChangeResourceRecordSets",
    ]

    resources = [
      "arn:aws:route53:::hostedzone/*",
    ]
  }
}

data "aws_iam_policy_document" "external_dns_assumerole" {
  count = var.deploy_external_dns ? 1 : 0

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.oidc_provider.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")}:sub"
      values   = [
        "system:serviceaccount:kube-system:external-dns"
      ]
    }
  }
}

resource "aws_iam_policy" "external_dns" {
  count = var.deploy_external_dns ? 1 : 0

  name        = "${local.csi}-extdns"
  description = "Permissions for ${local.csi} cluster External DNS Deployment"
  policy      = data.aws_iam_policy_document.external_dns[0].json
}

resource "aws_iam_role" "external_dns" {
  count = var.deploy_external_dns ? 1 : 0

  name                  = "${local.csi}-extdns"
  force_detach_policies = true
  assume_role_policy    = data.aws_iam_policy_document.external_dns_assumerole[0].json
  tags                  = local.default_tags
}

resource "aws_iam_role_policy_attachment" "external_dns" {
  count = var.deploy_external_dns ? 1 : 0

  policy_arn = aws_iam_policy.external_dns[0].arn
  role       = aws_iam_role.external_dns[0].name
}

resource "kubernetes_service_account" "external_dns" {
  count = var.deploy_external_dns ? 1 : 0

  metadata {
    name      = "external-dns"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.external_dns[0].arn
    }
  }

  automount_service_account_token = true
}

resource "kubernetes_cluster_role" "external_dns" {
  count = var.deploy_external_dns ? 1 : 0

  metadata {
    name      = "system:external-dns"
  }

  rule {
    api_groups = [""]
    resources  = [
      "services",
      "endpoints",
      "pods",
    ]
    verbs      = [
      "get",
      "list",
      "watch"
    ]
  }

  rule {
    api_groups = [
      "extensions",
      "networking.k8s.io",
    ]
    resources  = ["ingresses"]
    verbs      = [
      "get",
      "list",
      "watch"
    ]
  }

  rule {
    api_groups = [""]
    resources  = ["nodes"]
    verbs      = [
      "list",
      "watch"
    ]
  }
}

resource "kubernetes_cluster_role_binding" "external_dns" {
  count = var.deploy_external_dns ? 1 : 0

  metadata {
    name      = "external-dns-viewer"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.external_dns[0].metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.external_dns[0].metadata[0].name
    namespace = kubernetes_service_account.external_dns[0].metadata[0].namespace
  }
}

resource "kubernetes_deployment" "external_dns" {
  count = var.deploy_external_dns ? 1 : 0

  metadata {
    name      = "external-dns"
    namespace = "kube-system"
  }

  spec {
    strategy {
      type = "Recreate"
    }

    selector {
      match_labels = {
        "app" = "external-dns"
      }
    }

    template {
      metadata {
        labels = {
          "app" = "external-dns"
        }
      }

      spec {
        service_account_name            = kubernetes_service_account.external_dns[0].metadata[0].name
        automount_service_account_token = true

        container {
          name              = "external-dns"
          image             = "k8s.gcr.io/external-dns/external-dns:v0.7.3"
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
            "--source=service",
            "--source=ingress",
            "--provider=aws",
            "--registry=txt",
            "--txt-owner-id=${aws_eks_cluster.main.arn}",
          ]
        }
        security_context {
            fs_group = 65534
        }
      }
    }
  }

  depends_on = [
    # Explicitly wait until we have nodes to deploy the replica set onto
    aws_eks_node_group.node_groups,
  ]
}
