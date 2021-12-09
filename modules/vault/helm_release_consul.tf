resource "helm_release" "consul" {
  name       = "consul"
  chart      = "consul"
  repository = "https://helm.releases.hashicorp.com"

  set {
    name  = "global.name"
    value = "vault-consul"
  }

  set {
    name  = "server.replicas"
    value = 1
  }

  set {
    name  = "server.bootstrapExpect"
    value = 1
  }

  # set {
  #   name  = "global.image"
  #   value = "${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-west-2.amazonaws.com/consul:1.8.0"
  # }

  # set {
  #   name  = "global.imageK8S"
  #   value = "${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-west-2.amazonaws.com/consul-k8s:0.17.0"
  # }
}
