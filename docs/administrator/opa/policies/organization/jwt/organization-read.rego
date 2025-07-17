package organization.read

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
}