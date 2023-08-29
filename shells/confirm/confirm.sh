#!/bin/bash

confirm() {
  echo "Are you sure you want to proceed? (y/n)"
  read -r response

  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    "$@"
  else
    echo "Aborted."
  fi
}
