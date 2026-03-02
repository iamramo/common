#!/bin/bash

git-default-branch() {
  local branch
  branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|.*/||')
  [[ -n "$branch" ]] && echo "$branch" && return
  git rev-parse --verify main &>/dev/null && echo main && return
  git rev-parse --verify master &>/dev/null && echo master && return
}
