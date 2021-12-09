# The tooling development environment in the tooling account...

environment = "ptfnl"
component   = "ptf"
vpc_cidr    = "10.4.0.0/20"

subnets = {
  control = "4,4",
  worker  = "4,7",
  lb      = "4,10",
}

route_53_zone_name = "evo-tl1.test-and-trace.nhs.uk"

aws_auth_map_additional_roles = [
  {
    rolearn  = "arn:aws:iam::421351587426:role/AWSReservedSSO_Administrator_054776592bf5d3e7"
    username = "administrator"
    groups = [
    "system:masters"]
  },
  {
    rolearn : "arn:aws:iam::421351587426:role/evo-development-ctf-k8s-admins"
    username : "system:node:{{EC2PrivateDNSName}}"
    groups : [
      "system:bootstrappers",
    "system:nodes"]
  },
  {
    rolearn : "arn:aws:iam::421351587426:role/evo-development-ctf-k8s-ng"
    username : "system:node:{{EC2PrivateDNSName}}"
    groups : [
      "system:bootstrappers",
    "system:nodes"]
  },
]

aws_auth_map_additional_users = [
  {
    userarn  = "arn:aws:sts::421351587426:assumed-role/AWSReservedSSO_Administrator_054776592bf5d3e7/Dheeraj.Vanteru@dhsc.gov.uk"
    username = "dheeraj.vanteru"
    groups = [
    "system:masters"]
  },
  {
    userarn  = "arn:aws:sts::421351587426:assumed-role/AWSReservedSSO_Administrator_054776592bf5d3e7/claudio.garcia@dhsc.gov.uk"
    username = "claudio.garcia"
    groups = [
    "system:masters"]
  },
  {
    userarn  = "arn:aws:sts::421351587426:assumed-role/AWSReservedSSO_Administrator_054776592bf5d3e7/alvaro.rebon@dhsc.gov.uk"
    username = "alvaro.rebon"
    groups = [
    "system:masters"]
  }
]

# Internal Route 53
tld_internal_name = "evo-tl1.internal"
subdomain         = "evo-tl1"

jenkins_image_path = "421351587426.dkr.ecr.eu-west-2.amazonaws.com/jenkins/jenkins"
jenkins_image_tag  = "2.266-withplugins"