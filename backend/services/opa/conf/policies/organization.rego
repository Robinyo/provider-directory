package organization

import input.request

default allow := false

allow if {
	request.method == "GET"
}