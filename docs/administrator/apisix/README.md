<h1 align="center">Working with APISIX</h1>

## ❯ APISIX

### Open Policy Agent plugin

The `opa` plugin enables APISIX to integrate with Open Policy Agent.

#### Configure APISIX

Create a route as follows:

```

  ...

  - name: provider-directory-api-organization-read
    uri: /fhir/Organization*
    methods: [ "GET", "HEAD" ]
    upstream_id: 1
    plugins:
      opa:
        host: "http://opa:8181"
        policy: "organization/read"
```

See: [apisix-standalone.yml](https://github.com/Robinyo/hapi-fhir-au/blob/main/backend/services/apisix/conf/apisix-standalone.yml)

## ❯ References

### APISIX

* APISIX docs: [Plugins - Open Policy Agent](https://apisix.apache.org/docs/apisix/plugins/opa/)
