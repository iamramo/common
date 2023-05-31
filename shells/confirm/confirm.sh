#!/usr/bin/env sh

function confirm() {
  echo "Are you sure you want to proceed? (y/n)"
  read response

  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    "$@"
  else
    echo "Aborted."
  fi
}
