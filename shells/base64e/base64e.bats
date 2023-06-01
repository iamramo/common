#!/usr/bin/env bats

load './base64e.sh'

@test "base64 encoding" {
  local input="Hello world"
  local expected_output="SGVsbG8gd29ybGQ="

  run base64e "$input"

  [ "$status" -eq 0 ]
  [ "$output" == "$expected_output" ]
}
