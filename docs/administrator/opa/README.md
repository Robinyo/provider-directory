<h1 align="center">REST API</h1>

### Common Request Headers

The following request headers are commonly used in some API endpoints:

#### Content-Type

It indicates the request body format. These are some values used in some APIs:

```
--header 'Content-Type: application/json' for JSON encoded content, e.g., a JSON document
--header 'Content-Type: application/yaml' for YAML encoded content, e.g., a YAML document
--header 'Content-Type: text/plain' for plain text content, e.g., a policy
```

### Policy API

The Policy API exposes CRUD endpoints for managing policy modules. Policy modules can be added, removed, and modified at any time.

The identifiers given to policy modules are only used for management purposes. They are not used outside the Policy API.

#### List Policies

```
curl -X GET https://provider-directory.au.localhost/v1/policies?pretty=true \
  -H 'Content-Type: application/json'
```

#### Get a Policy

```
curl -X GET https://provider-directory.au.localhost/v1/policies/organization?pretty=true \
  -H 'Content-Type: application/json'
```

#### Create or Update a Policy

```
curl --location --request PUT 'https://provider-directory.au.localhost/v1/policies/organization' \
--header 'Content-Type: application/json' \
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
```

#### Delete a Policy

```
curl --location --request DELETE 'https://provider-directory.au.localhost/v1/policies/organization'
```

### Query API

#### Execute a Simple Query

```
curl --location 'https://provider-directory.au.localhost/v1/data/organization' \
  --header 'Content-Type: application/json' \
  --data '{
  "request": {
    "method": "GET"
  }
}' 
```
