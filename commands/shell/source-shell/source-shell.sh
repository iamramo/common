#!/bin/bash

source-shell() {
  local target_file="$HOME/.shell-sources"

  echo -n > "$target_file"

  for src_dir in "$@"; do
    find "$src_dir" -type f -name "*.sh" -print | sort | while read -r file; do
      echo "source $file" >> "$target_file"
    done
  done
}
