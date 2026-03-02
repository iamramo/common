#!/bin/bash

cert-info() {
  local host="$1"
  local port="${2:-443}"
  echo | openssl s_client -connect "${host}:${port}" -servername "$host" 2>/dev/null \
    | openssl x509 -noout -subject -issuer -dates
}
