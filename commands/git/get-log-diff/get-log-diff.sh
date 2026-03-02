#!/bin/bash

get-log-diff() {
  local from="$1"
  local to="$2"

  # Fetch latest for branches
  if [[ ! "$from" =~ ^[0-9a-fA-F]{7,40}$ ]]; then
    git fetch origin "${from}:${from}"
  fi
  if [[ ! "$to" =~ ^[0-9a-fA-F]{7,40}$ ]]; then
    git fetch origin "${to}:${to}"
  fi

  git --no-pager log "${from}..${to}" --oneline
}
