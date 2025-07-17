package organization.write

methods := "POST PUT PATCH DELETE"

default allow := false

allow if contains(methods, input.request.method)
