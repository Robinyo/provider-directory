package organization.write

import rego.v1

import input.request

default allow := false

methods := "POST PUT PATCH DELETE"

allow if contains(methods, request.method)
