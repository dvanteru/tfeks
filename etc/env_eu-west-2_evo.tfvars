# The tooling development environment in the tooling account...

environment = "development"

##
# CTF Component
##

vpc_cidr = "10.4.0.0/20"

subnets = {
  control = "4,4",
  worker  = "4,7",
  lb      = "4,10",
}

route_53_zone_name = "evo-tl1.test-and-trace.nhs.uk"

aws_auth_map_additional_roles = [
  {
    rolearn  = "arn:aws:iam::221917798434:role/aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_Administrator_054776592bf5d3e7"
    username = "sso_admin"
    groups   = [ "system:masters" ]
  },
]

aws_auth_map_additional_users = [
  {
    userarn  = "arn:aws:sts::221917798434:assumed-role/AWSReservedSSO_Administrator_054776592bf5d3e7/Dheeraj.Vanteru@dhsc.gov.uk"
    username = "dheeraj.vanteru"
    groups   = ["system:masters"]
  },
  {
    userarn = "arn:aws:sts::221917798434:assumed-role/AWSReservedSSO_Administrator_054776592bf5d3e7/claudio.garcia@dhsc.gov.uk"
    username = "claudio.garcia"
    groups   = ["system:masters"]
  },
  {
    userarn = "arn:aws:sts::221917798434:assumed-role/AWSReservedSSO_Administrator_054776592bf5d3e7/alvaro.rebon@dhsc.gov.uk"
    username = "alvaro.rebon"
    groups   = ["system:masters"]
  }
]

# Internal Route 53
tld_internal_name    = "evo-tl1.internal"
subdomain             = "evo-tl1.evo"
