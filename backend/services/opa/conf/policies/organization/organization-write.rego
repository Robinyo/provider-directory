package organization.write

import rego.v1

import input.request

default allow := false

allow if {
	request.method == "GET"
}