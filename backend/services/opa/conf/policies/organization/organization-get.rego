package organisation

default allow := false

allow if {
  request.method == "GET"
}
