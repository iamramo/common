#!/usr/bin/env sh

function source-shell() {
  src_dir="$1"
  target_file="$HOME/.shell-sources"

  echo -n > $target_file

  find "$src_dir" -type f -name "*.sh" -print | while read -r file; do
    echo "source $file" >> $target_file
  done
}
