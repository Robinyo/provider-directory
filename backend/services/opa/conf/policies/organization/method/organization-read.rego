package organization.read

import rego.v1

methods := "GET HEAD"

default allow := false

allow if contains(methods, input.request.method)