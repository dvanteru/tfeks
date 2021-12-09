# The first idempotent development environment in the development account...

environment = "d5"

cidr_blocks = {
  "cidr001"      = "172.16.0.0/20"
}

service = {
  "code"      = "CTF-PTF"
  "type"      = "HALO"
}


gitrepo = "github.com:test-and-trace/halo-evo-testing-tooling.git"


ctf001_subnets =  [ "172.16.0.0/23", "172.16.2.0/23", "172.16.4.0/23" ]
ptf001_subnets =  [ "172.16.6.0/23", "172.16.8.0/23", "172.16.10.0/23" ]
iac001_subnets =  [ "172.16.12.0/24", "172.16.13.0/24", "172.16.14.0/24" ]
servicex_subnets =   [ "172.16.15.0/27", "172.16.15.32/27", "172.16.15.64/27" ]
external_subnets =   [ "172.16.15.96/27", "172.16.15.128/27", "172.16.15.160/27" ]

az_zones = [ "eu-west-2a", "eu-west-2b","eu-west-2c"]

cluster_version = "1.18"


eks_worker_ami_id = "ami-0107478b0b67378c8"

ecr_endpoint = "025666326953.dkr.ecr.eu-west-2.amazonaws.com"

region = "eu-west-2"

testing_route53_zone = "nhs-internal.co.uk"
domains_list         = [ "nhs-internal.co.uk" ]


efs = {
  "ctf_s3bucket"          = "evo-tfscaffold-025666326953-eu-west-2"
  "ctf_state_file_key"    = "evo/025666326953/eu-west-2/d5/ctf_eks_cluster_workers.tfstate"
  "region"                = "eu-west-2"
}

aws_configmap_roles = [
    {
      rolearn  = "arn:aws:iam::025666326953:role/AWSReservedSSO_Administrator_054776592bf5d3e7"
      username = "admin"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::025666326953:role/ctf001-eks-iac-host"
      username = "adminhost"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::025666326953:role/ptf001-eks-iac-host"
      username = "adminhost"
      groups   = ["system:masters"]
    },
    {
      rolearn: "arn:aws:iam::025666326953:role/ctf001-eks-worker"
      username: "system:node:{{EC2PrivateDNSName}}"
      groups: ["system:bootstrappers", "system:nodes" ]
    },
    {
      rolearn: "arn:aws:iam::025666326953:role/ptf001-eks-worker"
      username: "system:node:{{EC2PrivateDNSName}}"
      groups: ["system:bootstrappers", "system:nodes" ]
    },
]
