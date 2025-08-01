<h1 align="center">Quick Start Guide</h1>

### Clone the project

Change the current working directory to the location where you want the cloned project to be:

```
cd ~/workspace
```


Clone the project by running the following command:

```
git clone git@github.com:Robinyo/provider-directory.git
``` 

### Enable TLS

#### Local Development

Follow the steps in the project's Developer Documentation to use [mkcert](../mkcert/README.md) to create and install a 
local certificate authority and to generate the certificates required to enable TLS.

### Docker Compose

With a single command, you can create and start all the services:

```
cd ~/workspace/provider-directory/backend

docker compose up
```

**Note:** Docker Compose will look for an `.env` file in the current working directory.

#### OpenAPI (Swagger)

Navigate to the OpenAPI (Swagger) UI for the FHIR Server.

For example:

```
https://provider-directory.au.localhost/fhir
https://provider-directory.au.localhost/fhir/swagger-ui/?page=Practitioner
https://provider-directory.au.localhost/fhir/swagger-ui/?page=PractitionerRole
https://provider-directory.au.localhost/fhir/swagger-ui/?page=Organization
https://provider-directory.au.localhost/fhir/swagger-ui/?page=HealthcareService
https://provider-directory.au.localhost/fhir/swagger-ui/?page=Location
```

You should see something like:

<p align="center">
  <img src="./provider-directory-openapi-ui.png" alt="FHIR Server OpenAPI UI"/>
</p>

To stop the services:

```
docker compose stop
```

To remove the services:

```
docker compose down
```

To remove the data volumes:

```
docker volume rm backend_postgres_data
```

### Call the Provider Directory API

#### OAuth 2.0 Client Credentials Grant

You must allow the 'Service account roles' capability config setting in order to enable support for the OAuth 2.0 **Client Credentials grant**:

<p align="center">
  <img src="./hapi-fhir-service-account-roles.png" alt="Keycloak Capability Config"/>
</p>

#### Endpoints

To discover the endpoints exposed by Keycloak use the following command:

```
curl https://keycloak.au.localhost:8443/realms/hapi-fhir-dev/.well-known/openid-configuration
```

You should see something like:

```
{
  "issuer": "https://keycloak.au.localhost:8443/realms/hapi-fhir-dev",
  "authorization_endpoint": "https://keycloak.au.localhost:8443/realms/hapi-fhir-dev/protocol/openid-connect/auth",
  "token_endpoint": "https://keycloak.au.localhost:8443/realms/hapi-fhir-dev/protocol/openid-connect/token",
  "introspection_endpoint": "https://keycloak.au.localhost:8443/realms/hapi-fhir-dev/protocol/openid-connect/token/introspect",
  "userinfo_endpoint": "https://keycloak.au.localhost:8443/realms/hapi-fhir-dev/protocol/openid-connect/userinfo",
  "end_session_endpoint": "https://keycloak.au.localhost:8443/realms/hapi-fhir-dev/protocol/openid-connect/logout",
  "frontchannel_logout_session_supported": true,
  "frontchannel_logout_supported": true,
  "jwks_uri": "https://keycloak.au.localhost:8443/realms/hapi-fhir-dev/protocol/openid-connect/certs",

  ...
  
  "registration_endpoint": "https://keycloak.au.localhost:8443/realms/hapi-fhir-dev/clients-registrations/openid-connect",
  
  '''  

}
```

#### Request a token

To access the API, you must request an access token. You will need to POST to the token URL.

For example (`scope=system/Organization.read`):

```
ACCESS_TOKEN=$(curl -s -X POST https://keycloak.au.localhost:8443/realms/hapi-fhir-dev/protocol/openid-connect/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d grant_type=client_credentials \
  -d client_id=oauth2-proxy \
  -d client_secret=aHkRec1BYkfaKgMg164JmvKu8u9iWNHM \
  -d resource=https://provider-directory.au.localhost/fhir/Organization \
  -d scope=system/Organization.read | (jq -r '.access_token'))
                 
# echo "$ACCESS_TOKEN"                 
```

**Note:** Keycloak does not currently support [Resource Indicators for OAuth 2.0](https://datatracker.ietf.org/doc/html/rfc8707).

**Note:** You can use [jwt.io](https://jwt.io/) to decode the access token.

#### Introspect a token

To introspect an Access Token you will need to POST to the introspect URL.

For example:

```
curl -X POST "https://keycloak.au.localhost:8443/realms/hapi-fhir-dev/protocol/openid-connect/token/introspect" \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d client_id=oauth2-proxy \
  -d client_secret=aHkRec1BYkfaKgMg164JmvKu8u9iWNHM \
  -d "token_type_hint=access_token&token=$ACCESS_TOKEN"
```

#### Call the API

To call the API, an application must pass the access token as a Bearer token in the Authorization header of the HTTP request.

For example:

```
curl -X GET https://provider-directory.au.localhost/fhir/Organization?_id=adv-hearing-care \
  -H 'Content-Type: application/fhir+json' \
  -H "Authorization: Bearer $ACCESS_TOKEN"
```

You should see something like:

```
{
  "resourceType": "Bundle",
  "id": "d049517a-9ff0-47e3-a3ff-c19f3d7615a6",
  "meta": {
    "lastUpdated": "2025-06-12T01:19:04.156+00:00"
  },
  "type": "searchset",
  "total": 1,
  "link": [ {
    "relation": "self",
    "url": "https://hapi-fhir.au.localhost/fhir/Organization?_id=adv-hearing-care"
  } ],
  "entry": [ {
    "fullUrl": "https://hapi-fhir.au.localhost/fhir/Organization/adv-hearing-care",
    "resource": {
      "resourceType": "Organization",
      "id": "adv-hearing-care",
      "meta": {
        "versionId": "1",
        "lastUpdated": "2025-06-12T01:18:33.852+00:00",
        "source": "#CVStmTGW0vAqtHXS",
        "profile": [ "http://hl7.org.au/fhir/core/StructureDefinition/au-core-organization" ]
      },
      "identifier": [ {
        "type": {
          "coding": [ {
            "system": "http://terminology.hl7.org/CodeSystem/v2-0203",
            "code": "XX"
          } ],
          "text": "ABN"
        },
        "system": "http://hl7.org.au/id/abn",
        "value": "12345678901"
      } ],
      "active": true,
      "name": "Audiology Advanced Hearing Care",
      "telecom": [ {
        "system": "email",
        "value": "info@ahc.example.com",
        "use": "work"
      } ]
    },
    "search": {
      "mode": "match"
    }
  } ]
}
```

### Keycloak

#### Admin Console

To navigate to the Keycloak Admin Console (username: temp-admin and password: secret):

```
https://keycloak.au.localhost:8443
```

You should see something like:

<p align="center">
  <img src="./keycloak-welcome-page.png" alt="Keycloak Admin Console Welcome page"/>
</p>

Follow these [steps](../../administrator/keycloak/README.md) to create a permanent admin account.

You can preview tokens in the Keycloak Admin Console, for example:

<p align="center">
  <img src="./keycloak-generated-id-token.png" alt="Generated ID Token"/>
</p>

#### Account Console

To navigate to the Keycloak Account Console:

```
https://keycloak.au.localhost:8443/realms/hapi-fhir-dev/account
```

You should see something like:

<p align="center">
  <img src="./keycloak-account-welcome-page.png" alt="Keycloak Account Console Welcome page"/>
</p>
