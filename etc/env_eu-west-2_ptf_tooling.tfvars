# The tooling development environment in the tooling account...

environment = "ptf_tooling"

##
# PTF Component
##
component = "ptf"
vpc_cidr = "10.1.96.0/20"

subnets = {
  control = "7,64",
  worker  = "4,13",
  lb      = "7,32",
}

route_53_zone_name = "collab-tooling.test-and-trace.nhs.uk"

aws_auth_map_additional_roles = [
  {
    rolearn  = "arn:aws:iam::859104490301:role/AWSReservedSSO_Administrator_dabf49be1f800d16"
    username = "administrator"
    groups = [
    "system:masters"]
  },
]

aws_auth_map_additional_users = [
  {
    userarn  = "arn:aws:sts::859104490301:assumed-role/AWSReservedSSO_Administrator_dabf49be1f800d16/Dheeraj.Vanteru@dhsc.gov.uk"
    username = "dheeraj.vanteru"
    groups = [
    "system:masters"]
  },
  {
    userarn  = "arn:aws:sts::859104490301:assumed-role/AWSReservedSSO_Administrator_dabf49be1f800d16/claudio.garcia@dhsc.gov.uk"
    username = "claudio.garcia"
    groups = [
    "system:masters"]
  },
  {
    userarn  = "arn:aws:sts::859104490301:assumed-role/AWSReservedSSO_Administrator_dabf49be1f800d16/alvaro.rebon@dhsc.gov.uk"
    username = "alvaro.rebon"
    groups = [
    "system:masters"]
  }
]

# Internal Route 53
tld_internal_name = "collab-tooling.internal"
subdomain         = "collab-tooling"

jenkins_image_path = "859104490301.dkr.ecr.eu-west-2.amazonaws.com/jenkins/jenkins"
jenkins_image_tag  = "2.266-withplugins"