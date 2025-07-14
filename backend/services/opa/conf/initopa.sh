#! /usr/bin/env sh
set -e
set -x

export OPA_SERVICE_PROTOCOL=${OPA_SERVICE_PROTOCOL:-http}
# export OPA_SERVICE_PROTOCOL=${OPA_SERVICE_PROTOCOL:-https}
export OPA_SERVICE_HOST=${OPA_SERVICE_HOST:-opa}
export OPA_SERVICE_ADMIN_PORT=${OPA_SERVICE_ADMIN_PORT:-8181}
# export OPA_SERVICE_ADMIN_PORT=${OPA_SERVICE_ADMIN_PORT:-8282}

# Policies

# organization.read

curl --location --silent --show-error --fail --request PUT "${OPA_SERVICE_PROTOCOL}://${OPA_SERVICE_HOST}:${OPA_SERVICE_ADMIN_PORT}/v1/policies/organization" \
  --header 'Content-Type: text/plain' \
  --data 'package organization.read

methods := "GET HEAD"
path := "/fhir/Organization"
scope := "system/Organization.read"

default allow := false

allow if {
  is_method
	is_request_path
	is_scope
	is_client
}

is_method if contains(methods, input.request.method)
is_request_path if input.request.path == path
is_scope if contains(token.scope, scope)

is_client if token.azp == "oauth2-proxy"

bearer_token := t if {
	v := input.request.headers.authorization
	startswith(v, "Bearer ")
	t := substring(v, count("Bearer "), -1)
}

token := payload if {
	[_, payload, _] := io.jwt.decode(bearer_token)
}'

# organization.write

curl --location --silent --show-error --fail --request PUT "${OPA_SERVICE_PROTOCOL}://${OPA_SERVICE_HOST}:${OPA_SERVICE_ADMIN_PORT}/v1/policies/organization" \
  --header 'Content-Type: text/plain' \
  --data 'package organization.write

methods := "POST PUT PATCH DELETE"

default allow := false

allow if contains(methods, input.request.method)'
