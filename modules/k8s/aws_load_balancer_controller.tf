data "aws_iam_policy_document" "aws_lb_ctlr" {
    count = var.deploy_aws_load_balancer_controller ? 1 : 0

  statement {
    effect = "Allow"

    actions = [
      "acm:DescribeCertificate",
      "acm:ListCertificates",
      "cognito-idp:DescribeUserPoolClient",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateSecurityGroup",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeInstances",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeTags",
      "ec2:DescribeVpcs",
      "ec2:RevokeSecurityGroupIngress",
      "elasticloadbalancing:AddListenerCertificates",
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:CreateRule",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:DeleteRule",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeListenerCertificates",
      "elasticloadbalancing:DescribeSSLPolicies",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:ModifyRule",
      "elasticloadbalancing:RemoveListenerCertificates",
      "elasticloadbalancing:SetWebAcl",
      "iam:CreateServiceLinkedRole",
      "iam:GetServerCertificate",
      "iam:ListServerCertificates",
      "shield:CreateProtection",
      "shield:DeleteProtection",
      "shield:DescribeProtection",
      "shield:GetSubscriptionState",
      "waf-regional:AssociateWebACL",
      "waf-regional:DisassociateWebACL",
      "waf-regional:GetWebACL",
      "waf-regional:GetWebACLForResource",
      "wafv2:AssociateWebACL",
      "wafv2:DisassociateWebACL",
      "wafv2:GetWebACL",
      "wafv2:GetWebACLForResource",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateTags",
    ]

    resources = [
      "arn:aws:ec2:*:*:security-group/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "ec2:CreateAction"
      values   = [
        "CreateSecurityGroup"
      ]
    }

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = [
        "false"
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags",
    ]

    resources = [
      "arn:aws:ec2:*:*:security-group/*",
    ]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = [
        "true",
      ]
    }

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = [
        "false",
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:DeleteSecurityGroup",
    ]

    resources = [
      "*",
    ]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = [
        "false",
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateTargetGroup",
    ]

    resources = [
      "*",
    ]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = [
        "false",
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags",
    ]

    resources = [
      "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*",
    ]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = [
        "true",
      ]
    }

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = [
        "false",
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:SetIpAddressType",
      "elasticloadbalancing:SetSecurityGroups",
      "elasticloadbalancing:SetSubnets",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:DeleteTargetGroup",
    ]

    resources = [
      "*",
    ]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = [
        "false",
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets",
    ]

    resources = [
      "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
    ]
  }
}

data "aws_iam_policy_document" "aws_lb_ctlr_assumerole" {
  count = var.deploy_aws_load_balancer_controller ? 1 : 0

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
        "system:serviceaccount:kube-system:aws-load-balancer-controller"
      ]
    }
  }
}

resource "aws_iam_policy" "aws_lb_ctlr" {
  count = var.deploy_aws_load_balancer_controller ? 1 : 0

  name        = "${local.csi}-aws-lb-ctlr"
  description = "Permissions for ${local.csi} cluster AWS Load Balancer Controller"
  policy      = data.aws_iam_policy_document.aws_lb_ctlr[0].json
}

resource "aws_iam_role" "aws_lb_ctlr" {
  count = var.deploy_aws_load_balancer_controller ? 1 : 0

  name                  = "${local.csi}-awslbctlr"
  force_detach_policies = true
  assume_role_policy    = data.aws_iam_policy_document.aws_lb_ctlr_assumerole[0].json
  tags                  = local.default_tags
}

resource "aws_iam_role_policy_attachment" "aws_lb_ctlr" {
  count = var.deploy_aws_load_balancer_controller ? 1 : 0

  policy_arn = aws_iam_policy.aws_lb_ctlr[0].arn
  role       = aws_iam_role.aws_lb_ctlr[0].name
}

resource "kubernetes_service_account" "aws_lb_ctlr" {
  count = var.deploy_aws_load_balancer_controller ? 1 : 0

  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.aws_lb_ctlr[0].arn
    }
  }

  automount_service_account_token = true
}

resource "helm_release" "aws_lb_ctlr" {
  count = var.deploy_aws_load_balancer_controller ? 1 : 0

  name       = "aws-load-balancer-controller"
  chart      = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"

  namespace = "kube-system"

  set {
    name  = "clusterName"
    value = aws_eks_cluster.main.name
  } 
  
  set {
    name  = "serviceAccount.create"
    value = false 
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.aws_lb_ctlr[0].metadata[0].name
  }

  set {
    name  = "enableWaf"
    value = true
  }

  set {
    name  = "enableWafv2"
    value = true
  }

  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.${var.region}.amazonaws.com/amazon/aws-load-balancer-controller"
  }

  depends_on = [
    aws_eks_node_group.node_groups
  ]
}
