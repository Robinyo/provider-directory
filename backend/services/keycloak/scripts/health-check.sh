#!/bin/bash

status=$(curl --insecure --silent https://hapi-fhir.au.localhost:9000/health/ready | (jq -r '.status'))

if [[ $status = 'UP' ]] ; then
    exit 0
  else
    exit 1
fi

# sudo chmod +x health-check.sh
