package organization.write

import rego.v1

methods := "POST PUT PATCH DELETE"

default allow := false

allow if contains(methods, input.request.method)
