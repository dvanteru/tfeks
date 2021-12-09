# terraformscaffold project for Halo

How to configure this default repository as the start of a Halo Infrastructure as Code project

This project makes use of tfscaffold (https://github.com/tfutils/tfscaffold) and tfenv (https://github.com/tfutils/tfenv) for managing project structure and versioning terraform. Familiarity with these tools is valuable, but not essential.

## Pre-requisites

### AWS Accounts

AWS Accounts must be requested from the Halo Hosting team. One of these accounts needs to be a "tooling" classification of account, which the other accounts will be told is their nominated tooling account to permit terraform to execute across them.

The information you will need from the hosting team:

* Your workload's name (synonymous with Organizational Unit name)
* Each account's AWS Account ID, e.g. 123456789012
* Each account's short-name, e.g. myworkload-tl1

### AWS VPCs

There is no hard requirement for a VPC to exist in a Halo AWS account, however if your workload requires a VPC in any given account, then one should be requested for that account that requires it from the Halo Hosting team. This VPC will come with an EC2 Transit Gateway attachment and three route tables: one for public communication, one for NAT Internet access and intra-Halo east-west connectivity via the EC2 Transit Gateway, and one for purely private communication with no Internet connectivity.

You are responsible for the creation of your own subnetsi, using these route tables, unless agreement is made with the Halo Hosting team to provision subnets for you.

### AWS Route53 Public Hosted Zones

The Halo Hosting team are able to provide you with one or more Public Hosted Zones as a subdomain of the parent Halo DNS zone in each AWS Account, whether as a single subdomain for your tooling account where you can place individual records, or to further subdomain in each account; or as a unique subdomain per-account. Please see the Halo Hosting Product Owner for details and documentation on what and how this request can be made. Any terraform code may then use a data source to look up the details of the subdomain and control the records within, as demonstrated in the `core` component.

### AWS Chatbot

If you intend to AWS Chatbot as configured in the provided ci or core components, or in your own configuration, you must first enable AWS Chatbot in the account in which you intend to use it, i.e. your Tooling account. This must be done manually from the AWS Console.

### GitHub Personal Access Token

If you intend to use the provided CI component (described below) to deploy terraform using AWS CodePipeline, you must first enter a GitHub Personal Access Token in to AWS Parameter Store as a Secret String parameter. The default parameter name configured for this is `/github/terraform`.

It is recommended, where possible, that this Personal Access Token be associated with a project-specific system user rather than an individual.

This access token must have permission to create webhooks as well as to clone source code from the configured GitHub repository.

## Files to Modify

### .env

Change the AWS Account ID to the ID of your tooling account

### Global Variables

* etc/global.tfvars

#### Project Name

Replace `myproject` with an identifier for your project in both the project and tfscaffold_bucket_prefix variables. Ideally this should be 4 characters long, no more than 6. This value will be used as part of the prefix for all of your resources. The shorter this string is, the lower the chance you will run out of characters allowed for naming resources.

#### Workload Name

Replace `myworkload` with the name of your workload as defined in the Halo Landing Zone tooling.

### Group (Account) Variables

Halo's default terraform automation approach uses tfscaffold groups to differentiate between AWS Accounts in deployment.

You need one group variables file for each of the AWS Accounts you will deploy to. Set the group variable to a unique identifier for each account. Set the aws_account_id variable to the ID of the AWS account in each case, and the account_short_name variable to the account short name defined in the Halo Landing Zone Account Vending Machine (this will allow you to easily data-source resources created by the Landing Zone Account Vending Machine).

Examples:
  * etc/group_tool.tfvars
  * etc/group_dev.tfvars
  * etc/group_test.tfvars
  * etc/group_prod.tfvars

This default configuration has already been set and only AWS account IDs and account shortnames need to be filled in, but this must be modified if you have an alternate account strategy.

### Environment Variables

Having first defined your initial approach to multi-environment deployment, configure environment variables files for environments you will deploy. Keep environment names as short as possible. See guidance on project naming in the Global Variables above.

Examples:
  * Tooling Account Environments:
    * etc/env_eu-west-2_tdev.tfvars  # Usually not required, but an option for testing the tooling implementation
    * etc/env_eu-west-2_tprod.tfvars
  * Path to Live Application Environments:
    * etc/env_eu-west-2_dev01.tfvars
    * etc/env_eu-west-2_int.tfvars
    * etc/env_eu-west-2_prod.tfvars

This default configuration has already been set, but this must be modified if you have an alternate environment strategy.

### Core Component (components/core)

Use this component as a template to create your own. Keep component names as short as possible. See guidance on project naming.
It's normal to use the core component without modification, just replacing the resources inside it with your own.

#### components/core/variables.tf

If you change the name of the component, make sure to change the default value of the component variable to match the new name of the component.

### CI Component (components/ci)

This component is pre-configured to deploy AWS CodePipeline pipelines for deploying your terraform. You should only need to change the pipelines you wish to create in the etc/env_eu-west-2_tprod.tfvars file.

## Bootstrapping your tfscaffold State File Bucket

1. Set environment credentials, e.g. by using the SSO portal to get environment credentials for an Administrator role in your tooling account.
2. `./bin/terraform.sh -p <your project name> -r eu-west-2 -g tool --bootstrap -a plan`
3. Verify the result of the plan. If as expected, continue to apply
4. `./bin/terraform.sh -p <your project name> -r eu-west-2 -g tool --bootstrap -a apply`

## (Optional) Deploying CI Tooling

Deploy the `tprod` environment's `ci` component into the tooling account (`tool` group).

1. `./bin/terraform.sh -p <your project name> -r eu-west-2 -g tool -e tprod -c ci -a plan`
2. `./bin/terraform.sh -p <your project name> -r eu-west-2 -g tool -e tprod -c ci -a apply`

## Writing Your Code

* Create resources in your main application component (i.e. the `core` component)
* Enter environmnt-specific variable values in your tfvars files, (i.e. etc/env_eu-west-2_dev01.tfvars , etc/env_eu-west-2_prod.tfvars )
* Push your changes to your code repository

### If you use the provided CI tooling

* Plans will initiate in your CodePipeline pipelines when your code is pushed to your configured branch

### If you apply terraform from a terminal

* Plan and Apply your resources, following the guidance in the README.md

Example: `./bin/terraform.sh -w -p <myproject> -r eu-west-2 -g dev  -e dev01 -c core -a plan`

Example: `./bin/terraform.sh -w -p <myproject> -r eu-west-2 -g prod -e prod  -c core -a plan`

## Using Modules

Until Halo is ready to provide a project-specific Terraform Registry, modules have been provided by the Halo Hosting team in this template repository to assist you.

### modules/chatbot

Creates an AWS ChatBot to Slack channel configuration

### modules/kms

Creates a KMS Customer Managed Key, with an associated Admin and User policy. You should always use CMKs, not account default service keys, and you should create unique keys for unique purposes.

### modules/lambdacron

Creates a simple lambda function based on provision of a text string one-file source template. Optionally allows you to define an EventBridge schedule for executing the function, optionally with custom data.

### modules/sftp

Advanced usage only - creates a reasonably standardised AWS SFTP Server implementation using AWS CloudFormation

### modules/simpipe

Should not be used in practice. This module provides an example of best practice, least privilege implementation for a simple CodePipeline pipeline using a single CodeBuild Project. Any potential candidate for this module should instead be simple enough to be just a CodeBuild Project, or complex enough that more pipeline steps are required, or multiple pipelines should share a CodeBuild Project. In either case this module can be used as reference, but should not be used on its own.

### modules/subdomain

Creates an AWS Route53 Delegation Set and Public Hosted Zone, entering the Nameserver records for the subdomain in the Hosted Zone of the parent domain

### modules/subnets

Creates a tuple of subnets, as many as required, looping over the availability zones currently available, based on the CIDR block of the local VPC, the number of bits to add to the CIDR mask and the netnum_root where the first subnet in the tuple will begin.

e.g. In a VPC of CIDR 10.0.0.0/20, a newbits value of 8 will make the subnets /28 subnets, a netnum_root value of 10 will begin the tuple at the 10th /28 CIDR in the VPC, and a count of 3 will create 3 subnets in each of three availability zones.

Result: 10.0.0.160/28 (eu-west-2a), 10.0.0.176/28 (eu-west-2b), 10.0.0.192/28 (eu-west-2c)

The route tables to use for creating subnets should be looked up using data sources as demonstrated in the core component (e.g. `components/core/data_aws_route_table_private.tf`)

### modules/tfp

Advanced usage only - created a standardised tfscaffold Terraform Pipeline based on a number of prerequisite shared resource, as per its usage in the `tfps` module

### module/tfps

The standard module for creating AWS CodePipeline tfscaffold Terraform pipelines as called from the `ci` component.

### module/vpceif

Creates a standard implementation of an AWS PrivateLink VPC Interface Endpoint for a supported AWS Service

## Docker Quickstart

This repo provides a way to get started with tfscaffold and tfenv from your console using a Docker image, which is the same image the CI component builds and uses for executing terraform in an AWS CodeBuild project.

This can be consumed in any way that fits. An example invocation is available from ./docker-quickstart.sh and docker-compose commands can be used to invoke the configuration in ./docker-compose.yaml. There is also a Makefile that can be used for building and pushing the image to the Terraform ECR Repository provided by the Halo AWS Account Vending Machine. This will be done for you if you deploy the CI component.

