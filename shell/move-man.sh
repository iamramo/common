function move-man() {
  src_dir="$1"

  dest_dir="/usr/local/share/man"

  for file in "$src_dir"/*.[0-9]*; do
    section=$(basename "$file" | awk -F. '{print $NF}')
    sudo cp "$file" "$dest_dir/man$section/"
  done
}
