#!/usr/bin/env bats

load './json-diff.sh'

@test "json-diff identical JSON files" {
  echo '{"name": "John", "age": 30}' > /tmp/file1.json
  echo '{"age": 30, "name": "John"}' > /tmp/file2.json

  run json-diff /tmp/file1.json /tmp/file2.json

  [ "$status" -eq 0 ]
  [ "$output" == "" ]
}

@test "json-diff different JSON files" {
  echo '{"name": "John", "age": 30}' > /tmp/file3.json
  echo '{"name": "Doe", "age": 30}' > /tmp/file4.json

  run json-diff /tmp/file3.json /tmp/file4.json

  [ "$status" -ne 0 ]
}

@test "json-diff with additional diff options" {
  echo '{"name": "John", "age": 30}' > /tmp/file5.json
  echo '{"name": "Doe", "age": 30}' > /tmp/file6.json

  # Use --brief option of diff to show only when files differ
  run json-diff /tmp/file5.json /tmp/file6.json --brief

  [ "$status" -ne 0 ]
  [ "$output" == "Files /dev/fd/63 and /dev/fd/62 differ" ]
}
