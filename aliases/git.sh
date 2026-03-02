#!/bin/bash

alias gs='git status'
alias gpo='git pull origin'

unalias gcm 2>/dev/null
gcm() { git checkout "$(git-default-branch)"; }

unalias gpom 2>/dev/null
gpom() { git pull origin "$(git-default-branch)"; }

unalias git-clean 2>/dev/null
git-clean() {
  local branch="$(git-default-branch)"
  git branch --merged "$branch" \
    | grep -v "^[ *]*${branch}$" \
    | xargs git branch -d
}
