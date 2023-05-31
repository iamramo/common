#!/usr/bin/env bats

load './base64d.sh'

@test "base64 decoding" {
  local input="SGVsbG8gd29ybGQhCg=="
  local expected_output="Hello world!"

  run base64d "$input"

  [ "$status" -eq 0 ]
  [ "$output" == "$expected_output" ]
}
