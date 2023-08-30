#!/bin/bash

json-diff() {
  file1="$1"
  file2="$2"
  shift 2
  diff "$@" <(jq --sort-keys . "$file1") <(jq --sort-keys . "$file2")
}
