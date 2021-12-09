#!/bin/bash

# Loading AWS from Your env.

# For AWS Profile controlled credentials
if [ -z "${AWS_PROFILE}" ]; then
  unset AWS_PROFILE
fi

# For raw sessions like manual MFA
if [ -z "${AWS_SESSION_TOKEN}" ]; then
  unset AWS_SESSION_TOKEN
fi

if [ -z "${AWS_SECRET_ACCESS_KEY}" ]; then
  unset AWS_SECRET_ACCESS_KEY
fi

if [ -z "${AWS_ACCESS_KEY_ID}" ]; then
  unset AWS_ACCESS_KEY_ID
fi

if [ -z "${AWS_MFA_EXPIRY}" ]; then
  unset AWS_MFA_EXPIRY
fi
