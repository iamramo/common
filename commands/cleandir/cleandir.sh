#!/bin/bash

cleandir() {
  if [[ -z "$1" ]]; then
    echo "Usage: cleandir <filename>"
    return 1
  fi

  find . -name "$1" -exec printf "\033[32m[Removing]\033[0m %s\n" {} \; -exec rm {} \;
}
