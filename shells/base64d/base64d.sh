#!/usr/bin/env sh

function base64d() {
  echo $(echo -n "$1" | base64 --decode)
}
