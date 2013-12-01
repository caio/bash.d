#!/bin/bash

__vcs_dir() {
  local vcs base_dir sub_dir ref RED YELLOW GREEN BLUE
  local LIGHT_RED LIGHT_GREEN WHITE LIGHT_GRAY COLOR_NONE

  RED="\[\033[0;31m\]"
  YELLOW="\[\033[0;35m\]"
  GREEN='\[\e[0;36m\]'
  BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
  LIGHT_GREEN="\[\033[1;32m\]"
  WHITE="\[\033[1;37m\]"
  LIGHT_GRAY="\[\033[0;37m\]"
  COLOR_NONE="\[\e[0m\]"

  sub_dir() {
    local sub_dir
    sub_dir=$(readlink -f "${PWD}")
    sub_dir=${sub_dir#$1}
    echo ${sub_dir#/}
  }

  git_dir() {

      parse_git_branch() {
          git_status="$(git status -b --porcelain --ignore-submodules 2> /dev/null)"

          # Index/Worktree status:
          #     green  => clean
          #     yellow => index modified (has precedence over red)
          #     red    => worktree modified
          local state="${GREEN}"
          if [[ ${git_status} =~ $'\n'(M |A |R |C |D ) ]]; then
              state="${YELLOW}"
          elif [[ ${git_status} =~ $'\n'( M| D|\?\?) ]]; then
              state="${RED}"
          fi

          local remote=""
          [[ ${git_status} =~ ^##.+\[.*ahead ]] && remote="↑"
          if [[ ${git_status} =~ ^##.+\[.*behind ]]; then
              # If behind AND ahead, the status is "diverged"
              test -z $remote && remote="↓" || remote="↕"
          fi

          # Get the name of the branch by trying to match
          #     ## branchname..upstream [ahead X, behind Y]
          if [[ ${git_status} =~ ^##\ ([^\ ]+)($'\n'| \[|$) ]]; then
              branch=${BASH_REMATCH[1]}
              # Remove the ...upstream part, if present
              branch=${branch%...*}
          fi

          echo "${state}${branch}${remote}${COLOR_NONE}"
      }
      base_dir=$(git rev-parse --git-dir 2>/dev/null) || return 1
      base_dir=$(readlink -f "$base_dir/..")
      sub_dir=$(git rev-parse --show-prefix)
      sub_dir=${sub_dir%/}
      ref=$(parse_git_branch)
      vcs="±"
  }

  git_dir ||
  base_dir="$PWD"

  __vcs_base_dir="${base_dir/$HOME/~}"
  if [ -n "$vcs" ]; then
      __vcs_prefix="$vcs"
      __vcs_ref="$ref"
      __vcs_sub_dir="${sub_dir}"
  else
      __vcs_prefix=""
      __vcs_ref=""
      __vcs_sub_dir=""
  fi
}
