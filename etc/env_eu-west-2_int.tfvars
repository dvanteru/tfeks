# The integration testing environment in the test account...

environment = "int"

##
# Core Component Variables
##

core_application_support_role_enable = false

core_chatbot = {
  enabled            = false
  slack_channel_id   = ""
  slack_workspace_id = ""
}

##
# Variables that apply generically to any component
##

# Public subdomain requested during account vend
# public_domain_name = "example-test.test-and-trace.nhs.uk"
