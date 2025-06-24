#! /usr/bin/env sh
set -e
set -x

export OPA_SERVICE_PROTOCOL=${OPA_SERVICE_PROTOCOL:-http}
# export OPA_SERVICE_PROTOCOL=${OPA_SERVICE_PROTOCOL:-https}
export OPA_SERVICE_HOST=${OPA_SERVICE_HOST:-opa}
export OPA_SERVICE_ADMIN_PORT=${OPA_SERVICE_ADMIN_PORT:-8181}
# export OPA_SERVICE_ADMIN_PORT=${OPA_SERVICE_ADMIN_PORT:-8282}

CURL_OPTS=" --silent --show-error --fail"
# CURL_OPTS=" --silent --show-error --fail --insecure"

# Policy - https://www.openpolicyagent.org/docs/rest-api#policy-api

curl $CURL_OPTS -X PUT "${OPA_SERVICE_PROTOCOL}://${OPA_SERVICE_HOST}:${OPA_SERVICE_ADMIN_PORT}/v1/policies/organization" \
  -H 'Content-Type: text/plain' \
  -d 'package organization

import rego.v1

import input.request

result := {
    "allow": true,
    "reason": "request.method == GET",
} if {
	request.method == "GET"
}'
