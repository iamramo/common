#!/usr/bin/env sh

function jq-compare() {
  diff <(jq --sort-keys . $1) <(jq --sort-keys . $2)
}
