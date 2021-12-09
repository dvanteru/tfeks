###########
## SETUP ##
###########

##
# Include and export all .env variables
#

cnf ?= .env
include $(cnf)
export $(shell sed "s/=.*//" $(cnf))
#

##
# Hey everyone, this guy's a PHONY!
#

.PHONY: $(shell echo -e "$(shell grep -e '^[^\s^.]\+:' Makefile | cut -d: -f1 | tr '\n' ' ')")
##

###########
## LOGIC ##
###########

deploy: docker-login docker-build docker-push

docker-login:
	aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

docker-build:
	docker-compose build

docker-push:
	docker-compose push

##
