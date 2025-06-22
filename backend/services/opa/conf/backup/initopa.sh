#! /usr/bin/env sh
set -e
set -x

# export OPA_SERVICE_PROTOCOL=${OPA_SERVICE_PROTOCOL:-http}
export OPA_SERVICE_PROTOCOL=${OPA_SERVICE_PROTOCOL:-https}
export OPA_SERVICE_HOST=${OPA_SERVICE_HOST:-opa}
# export OPA_SERVICE_ADMIN_PORT=${OPA_SERVICE_ADMIN_PORT:-8181}
export OPA_SERVICE_ADMIN_PORT=${OPA_SERVICE_ADMIN_PORT:-8282}

CURL_OPTS=" --silent --show-error --fail --insecure"

# Policy - https://www.openpolicyagent.org/docs/rest-api#policy-api

policyData=$(cat /organization.rego)
curl $CURL_OPTS -XPUT "${OPA_SERVICE_PROTOCOL}://${OPA_SERVICE_HOST}:${OPA_SERVICE_ADMIN_PORT}/v1/policies/organization" \
  --header 'Content-Type: text/plain' \
  --data-raw "$policyData"
# Used --data-raw to avoid "rego_parse_error" "unexpected eof token"

# Data - https://www.openpolicyagent.org/docs/rest-api#data-api

curl $CURL_OPTS -XPUT "${OPA_SERVICE_PROTOCOL}://${OPA_SERVICE_HOST}:${OPA_SERVICE_ADMIN_PORT}/v1/data/roles-and-permissions" \
  --header 'Content-Type: application/json' \
  --data @/roles-and-permissions.json

# https://github.com/arulrajnet/apisix-opa-example/blob/main/opa/opa-init.sh
