<p align="center">
  <img src="./logo.svg" alt="Provider Directory Starter Project" width="400"/>
</p>

<h1 align="center">Provider Directory Starter Project</h1>

<p align="center">
  The goal of this project is to demonstrate how an <b>Authorisation Service</b> can provide fine-grained access control for FHIR resources in a <b>Provider Directory</b>. <br>
</p>

## ❯ Introduction

In the Australian context, a healthcare provider can be defined as an individual or organisation involved in the delivery of healthcare services.

This broad definition encompasses a range of individuals, including doctors, nurses, and other health professionals, as well as organisations like hospitals, clinics, and aged care facilities.

### Individual Healthcare Providers

These are individuals who provide, have provided, or are intending to provide healthcare services. This includes registered health professionals such as medical practitioners, nurses, dentists, pharmacists, and allied health professionals.

**Note:** Individual healthcare providers are also referred to as healthcare practitioners.

### Organisational Healthcare Providers

These are organisations that deliver healthcare services. Examples include hospitals, day procedure centers, aged care facilities, and pathology or radiology services.

### Healthcare Identifiers

Healthcare Provider Identifiers (HPI-I and HPI-O) are used to uniquely identify individuals and organisations involved in the delivery of healthcare services.

![divider](./divider.png)

## ❯ Healthcare Provider Directory

A healthcare provider directory is a repository of information (where data is stored and maintained) about healthcare providers.

### FHIR Resources

There are a number of provider-related FHIR resources.

For example:

- Practioner
- Practioner Role
- Organization
- Healthcare Service
- Location

**Note:** As per the FHIR specifcation, the spelling of FHIR resource names (like "Organization") follows the American English standard.

### FHIR Operations

FHIR operations are interactions defined by the FHIR standard for manipulating healthcare data. They follow a RESTful paradigm, allowing for Create, Read, Update, Delete (CRUD) and Search actions on FHIR resources.

For example, to read Organisation information:

```
GET /Organization/{id}
```

![divider](./divider.png)

## ❯ Access Control

### Coarse-grained access control

How do we define coarse-grained access control?

Coarse-grained access control is when access to resources is granted or denied based on broad, general criteria, often at the role (RBAC) level. However, one or more scopes or claims may also be required.

### Fine-grained access control

How do we define fine-grained access control?

Fine-grained access control is when access to resources is granted or denied based on multiple conditions and may combine different access control mechanisms (ABAC, RBAC, ReBAC, UBAC).

**In the Australian Healthcare context, support for fine-grained access control is often required.**

For example, a Practitioner must be granted the Organisation Maintenance Officer role (RBAC) and have a membership relationship with an Organisation (ReBAC) in order to maintain healthcare service information on an Organisation's behalf.

![divider](./divider.png)

## ❯ Authorisation Service

The Authorisation Service is comprised of the following components:

- OAuth 2.0 Authorization Server (that supports the Token endpoint and the **Client Credentials grant**)
- OAuth 2.0 Security Token Service (that supports the Token endpoint and the **Token Exchange grant**)
- Policy Enforcement Point
- Policy Decision Point

Policies are enforced by the API Gateway ([APISIX](https://apisix.apache.org/docs/)).

Policy decisions (evaluation) are performed by the general purpose Policy Engine ([Open Policy Agent](https://www.openpolicyagent.org/docs)).

Policies are authored in [Rego](https://www.openpolicyagent.org/docs/policy-language).

Reference data (e.g., Roles, Permissions, Relationships) is loaded when the Policy Engine is healthy.

Policies are loaded when the Policy Engine is healthy and all Reference data has been loaded.

![divider](./divider.png)

## ❯ Documentation

* Developer Documentation
  * [Quick Start Guide](./docs/developer/quick-start-guide/README.md)
  * [mkcert](./docs/developer/mkcert/README.md)
* Administrator Documentation
  * [Working with APISIX](./docs/administrator/apisix/README.md)
  * [Working with Docker](./docs/administrator/docker/README.md)
  * [Working with Keycloak](./docs/administrator/keycloak/README.md)
  * [Working with the Provider Directory](./docs/administrator/hapi-fhir/README.md)
  * [Working with PostgreSQL](./docs/administrator/postgres/README.md)
  * [Working with pgAdmin](./docs/administrator/pgadmin/README.md)
  * [Working with the Percona Distribution for PostgreSQL](./docs/administrator/percona-distribution-for-postgresql/README.md)

![divider](./divider.png)

## ❯ Resources

* Rob Ferguson's blog: [Getting Started with HAPI FHIR](https://rob-ferguson.me/getting-started-with-hapi-fhir/)
* Rob Ferguson's blog: [HAPI FHIR and FHIR Implementation Guides](https://rob-ferguson.me/hapi-fhir-and-fhir-implementation-guides/)
* Rob Ferguson's blog: [HAPI FHIR and AU Core Test Data](https://rob-ferguson.me/hapi-fhir-and-au-core-test-data/)
* Rob Ferguson's blog: [Add AuthN to HAPI FHIR with OAuth2 Proxy, Nginx and Keycloak - Part 1](https://rob-ferguson.me/add-authn-to-hapi-fhir-with-oauth2-proxy-nginx-and-keycloak-part-1/)
* Rob Ferguson's blog: [Add AuthN to HAPI FHIR with OAuth2 Proxy, Nginx and Keycloak - Part 2](https://rob-ferguson.me/add-authn-to-hapi-fhir-with-oauth2-proxy-nginx-and-keycloak-part-2/)
* Rob Ferguson's blog: [Add AuthN to HAPI FHIR with OAuth2 Proxy, Nginx and Keycloak - Part 3](https://rob-ferguson.me/add-authn-to-hapi-fhir-with-oauth2-proxy-nginx-and-keycloak-part-3/)
* Rob Ferguson's blog: [Add AuthN to HAPI FHIR with OAuth2 Proxy, Nginx and Keycloak - Part 4](https://rob-ferguson.me/add-authn-to-hapi-fhir-with-oauth2-proxy-nginx-and-keycloak-part-4/)
* Rob Ferguson's blog: [Add AuthZ to HAPI FHIR - Part 1](https://rob-ferguson.me/add-authz-to-hapi-fhir-1/)
* Rob Ferguson's blog: [Add AuthZ to HAPI FHIR - Part 2](https://rob-ferguson.me/add-authz-to-hapi-fhir-2/)
* Rob Ferguson's blog: [Add AuthN to HAPI FHIR with APISIX and Keycloak](https://rob-ferguson.me/add-authn-to-hapi-fhir-with-apisix-and-keycloak/)
* Rob Ferguson's blog: [Add support for SMART on FHIR to HAPI FHIR with APISIX and Keycloak](https://rob-ferguson.me/add-authz-to-hapi-fhir-with-apisix-and-keycloak/)
* Rob Ferguson's blog: [Getting started with the APISIX authz-keycloak plugin](https://rob-ferguson.me/getting-started-with-the-apisix-authz-keycloak-plugin/)
* Rob Ferguson's blog: [Secure HAPI FHIR data in transit](https://rob-ferguson.me/secure-hapi-fhir-data-in-transit/)
* Rob Ferguson's blog: [Secure HAPI FHIR data at rest](https://rob-ferguson.me/secure-hapi-fhir-data-at-rest/)
* Rob Ferguson's blog: [Healthcare Provider Directory Access Control](https://rob-ferguson.me/healthcare-provider-directory-access-control/)

## ❯ References

### System Hardening

* Australian Signals Directorate: [Implementing Certificates, TLS, HTTPS and Opportunistic TLS](https://www.cyber.gov.au/resources-business-and-government/maintaining-devices-and-systems/system-hardening-and-administration/web-hardening/implementing-certificates-tls-https-and-opportunistic-tls)
* Cloudflare docs: [Cipher suites recommendations](https://developers.cloudflare.com/ssl/edge-certificates/additional-options/cipher-suites/recommendations/)

### OAuth 2.0

* IETF: [The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749)
* IETF: [The OAuth 2.0 Authorization Framework: Bearer Token Usage](https://datatracker.ietf.org/doc/html/rfc6750)
* IETF: [OAuth 2.0 Dynamic Client Registration Protocol](https://datatracker.ietf.org/doc/html/rfc7591)
* IETF: [OAuth 2.0 Token Exchange](https://datatracker.ietf.org/doc/html/rfc8693)
* IETF: [OAuth 2.0 for Browser-Based Applications](https://datatracker.ietf.org/doc/html/draft-ietf-oauth-browser-based-apps)
* Spring docs: [Implementation Guidelines for Browser-Based Applications](https://github.com/spring-projects/spring-authorization-server/issues/297#issue-896744390)

### HL7

* HL7: [Implementation Guide](https://www.hl7.org/fhir/implementationguide.html)
* HL7: [FHIR NPM Packages](https://hl7.org/fhir/packages.html)
* AU Core: [Publication (Version) History](https://hl7.org.au/fhir/core/history.html)
* AU Core FHIR Implementation Guide: [AU Core - 1.0.0-preview](https://hl7.org.au/fhir/core/1.0.0-preview/index.html)
* AU Core FHIR Implementation Guide: [Testing FAQs](https://confluence.hl7.org/display/HAFWG/AU+Core+FHIR+IG+Testing+FAQs)
* Sparked AU Core Test Data: [Postman collection](https://github.com/hl7au/au-fhir-test-data/blob/master/Postman/Sparked%20AUCore%20Test%20Data.postman_collection.json)
* HL7 AU: [Australian Provider Directory Implementation Guide](https://hl7.org.au/fhir/pd/pd2/index.html)

### SMART on FHIR

* HL7: [SMART App Launch](https://build.fhir.org/ig/HL7/smart-app-launch/)
* SMART Health IT: [SMART on FHIR](https://docs.smarthealthit.org/)
* Google Group: [SMART on FHIR](https://groups.google.com/g/smart-on-fhir)

#### SMART on FHIR - Standalone Launch

* Project Alvearie: [SMART App Launch](https://alvearie.io/blog/smart-keycloak/)
* Project Alvearie: [Keycloak extensions for FHIR](https://github.com/Alvearie/keycloak-extensions-for-fhir)
* Keycloak extensions for FHIR: [Upgrade to the Quarkus-based distribution](https://github.com/Alvearie/keycloak-extensions-for-fhir/issues/64)
* Keycloak discussion: [Fine grained scope consent management](https://github.com/keycloak/keycloak/discussions/10303)

#### SMART on FHIR - EHR Launch

* GitHub: [Zedwerks - Keycloak extensions for FHIR](https://github.com/zedwerks/keycloak-smart-fhir)

### Keycloak

* Keycloak docs: [Configuring Keycloak for production](https://www.keycloak.org/server/configuration-production)
* Keycloak docs: [Configuring TLS](https://www.keycloak.org/server/enabletls)
* Keycloak docs: [Configuring trusted certificates](https://www.keycloak.org/server/keycloak-truststore)
* Keycloak docs: [Configuring the hostname](https://www.keycloak.org/server/hostname)
* Keycloak docs: [Using a reverse proxy](https://www.keycloak.org/server/reverseproxy)
* Keycloak docs: [Running Keycloak in a container](https://www.keycloak.org/server/containers)
* Keycloak docs: [Migrating to the Quarkus distribution](https://www.keycloak.org/migration/migrating-to-quarkus)
* Keycloak docs: [Upgrading Guide - 26.1.0](https://www.keycloak.org/docs/latest/upgrading/)
* Keycloak docs: [Authorization Services Guide](https://www.keycloak.org/docs/latest/authorization_services/index.html)

### Keycloak-based  Development

* GitHub: [Keycloak Project Example](https://github.com/thomasdarimont/keycloak-project-example)
* GitHub: [Awesome Keycloak](https://github.com/thomasdarimont/awesome-keycloak)

### Keycloak Support

* Google Group: [Keycloak User](https://groups.google.com/g/keycloak-user)
* Google Group: [Keycloak Dev](https://groups.google.com/g/keycloak-dev)

### APISIX

* APISIX: [Documentation](https://apisix.apache.org/docs/)
* APISIX docs: [Deployment modes](https://apisix.apache.org/docs/apisix/deployment-modes/#standalone)
* APISIX docs: [SSL Protocol](https://apisix.apache.org/docs/apisix/ssl-protocol/)
* APISIX docs: [Certificate](https://apisix.apache.org/docs/apisix/certificate/)
* APISIX docs: [openid-connect plugin](https://apisix.apache.org/docs/apisix/plugins/openid-connect/)
* APISIX docs: [authz-keycloak plugin](https://apisix.apache.org/docs/apisix/plugins/authz-keycloak/)
* API7 docs: [authz-keycloak plugin](https://docs.api7.ai/hub/authz-keycloak)
* APISIX docs: [Code Samples](https://apisix.apache.org/docs/general/code-samples/)

### Open Policy Agent

* Open Policy Agent docs: [Introduction](https://www.openpolicyagent.org/docs)
* Styra docs: [Rego Style Guide](https://docs.styra.com/opa/rego-style-guide)
* GitHub: [Awesome OPA - A curated list of awesome OPA-related tools, frameworks and articles](https://github.com/StyraInc/awesome-opa)
* Open Policy Agent: [Playground](https://play.openpolicyagent.org/)
* Styra Academy courses: [OPA Policy Authoring](https://academy.styra.com/courses/opa-rego)
* Open Policy Agent: [Ecosystem](https://www.openpolicyagent.org/ecosystem/by-feature/learning-rego)

### HAPI FHIR

* HAPI FHIR: [Website](https://hapifhir.io/)
* HAPI FHIR: [Documentation](https://hapifhir.io/hapi-fhir/docs/)
* Google Group: [HAPI FHIR](https://groups.google.com/g/hapi-fhir)

### Terminology

* HL7 Australia: [Terminology](https://confluence.hl7.org/display/HAFWG/Terminology)
* ADHA: [National Clinical Terminology Service](https://www.healthterminologies.gov.au/)

### Miscellaneous 

* ADHA: [Strategies and plans](https://www.digitalhealth.gov.au/about-us/strategies-and-plans)
* ADHA: [Digital Health Standards Catalogue](https://developer.digitalhealth.gov.au/standards/search?keywords=&category=All&organisation=All)
