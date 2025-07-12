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
  -H 'Content-Type: application/fhir+json'
```

#### Create or Update a Policy

```
curl --location --request PUT 'https://provider-directory.au.localhost/v1/policies/organization' \
  --header 'Content-Type: application/json' \
  --data-binary 'package organization

import rego.v1

import input.request

default allow := false

allow if {
	request.method == "GET"
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
