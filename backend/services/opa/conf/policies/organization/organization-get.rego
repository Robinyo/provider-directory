package organization

default allow := false

allow if {
  request.method == "GET"
}
