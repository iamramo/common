#!/usr/bin/env sh

function jq-compare() {
  local file1="$1"
  local file2="$2"
  shift 2
  diff "$@" <(jq --sort-keys . "$file1") <(jq --sort-keys . "$file2")
}
