#!/usr/bin/env bats

load './jwtd.sh'

@test "jwt decoding" {
  local token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
  expected_result="{
  \"sub\": \"1234567890\",
  \"name\": \"John Doe\",
  \"iat\": 1516239022
}"

  run jwtd "$token"

  [ "$status" -eq 0 ]
  [ "$output" == "$expected_result" ]
}
