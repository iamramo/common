#!/usr/bin/env bats

load './jq-compare.sh'

@test "jq-compare identical JSON files" {
  echo '{"name": "John", "age": 30}' > /tmp/file1.json
  echo '{"age": 30, "name": "John"}' > /tmp/file2.json

  run jq-compare /tmp/file1.json /tmp/file2.json

  [ "$status" -eq 0 ]
  [ "$output" == "" ]
}

@test "jq-compare different JSON files" {
  echo '{"name": "John", "age": 30}' > /tmp/file3.json
  echo '{"name": "Doe", "age": 30}' > /tmp/file4.json

  run jq-compare /tmp/file3.json /tmp/file4.json

  [ "$status" -ne 0 ]
}