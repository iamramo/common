#!/bin/bash

genpass() {
  local length="${1:-16}"
  openssl rand -base64 48 | tr -dc 'A-Za-z0-9!@#$%^&*' | head -c "$length"
  echo
}
