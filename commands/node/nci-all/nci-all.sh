#!/bin/bash

nci-all() {
  local BOLD="\033[1m"
  local RESET="\033[0m"

  local dirs=($(find-package-dirs))
  local ci_pids=()
  declare -A dir_for_pid

  # Disable job-control messages like "[1] Done"
  set +m

  for dir in "${dirs[@]}"; do
    name="${dir#./}"
    if [ "$name" = "." ]; then name="root"; fi

    (
      echo "⚙️ Installing packages for ${BOLD}$name${RESET}"
      cd "$dir" && npm ci --legacy-peer-deps --loglevel=silent
    ) &

    pid=$!
    ci_pids+=("$pid")
    dir_for_pid[$pid]="$name"
  done

  echo

  # Wait for jobs to finish
  for pid in "${ci_pids[@]}"; do
    if wait "$pid"; then
      echo "✅ ${BOLD}$([[ -n ${dir_for_pid[$pid]} ]] && echo ${dir_for_pid[$pid]} || echo unknown)${RESET} completed successfully"
    else
      echo "❌ ${dir_for_pid[$pid]} failed"
    fi
  done

  # Buildable directories
  build_dirs=("common" "mv-agent")

  for dir in "${dirs[@]}"; do
    name="${dir#./}"
    if [ "$name" = "." ]; then name="root"; fi

    if [[ " ${build_dirs[*]} " =~ " $name " ]]; then
      echo
      echo "⚙️ Building ${BOLD}$name${RESET}"
      (cd "$dir" && npm run build > /dev/null 2>&1)
      echo
      echo "✅ ${BOLD}$name${RESET} built successfully"
    fi
  done
}
