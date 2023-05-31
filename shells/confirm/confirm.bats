#!/usr/bin/env bats

load './confirm.sh'

@test "confirm function with valid response" {
  # run confirm echo "Proceeding..."

  # [ "${lines[0]}" = "Are you sure you want to proceed? (y/n)" ]

  # echo "y" | "${lines[@]:3}"

  # [ "${status}" -eq 0 ]
  # [ "${lines[1]}" = "Proceeding..." ]
}

@test "confirm function with invalid response" {
  # run confirm echo "Proceeding..."

  # [ "${lines[0]}" = "Are you sure you want to proceed? (y/n)" ]

  # echo "n" | "${lines[@]:3}"

  # [ "${status}" -eq 0 ]
  # [ "${lines[1]}" = "Aborted." ]
}
