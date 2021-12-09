#!/usr/bin/env bash

. ./.env
aws ecr get-login-password --region $AWS_REGION | docker login
docker-compose -f docker-compose.yaml run terraform
