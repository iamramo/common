#!/bin/bash

jwtd() {
  jq -R 'split(".") | .[1] | @base64d | fromjson' <<< "$1"
}