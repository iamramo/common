#!/bin/bash

move-man() {
  src_dir="$1"
  dest_dir="/usr/local/share/man"

  find "$src_dir" -type f -name "*.[0-9]" -print | while read -r file; do
    section=$(basename "$file" | awk -F. '{print $NF}')
    sudo cp "$file" "$dest_dir/man$section/"
  done
}
