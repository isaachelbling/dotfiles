#!/bin/sh

# colors
export GRAY="\[\e[1;30m\]"
export RED="\[\e[1;31m\]"
export CYAN="\[\e[1;36m\]"
export LIGHT_CYAN="\[\e[0;36m\]"
export BR_YELLOW="\[\e[1;33m\]"
export DK_YELLOW="\[\e[0;33m\]"
export DK_GREEN="\[\e[0;32m\]"
export PERIWINKLE="\[\e[1;35m\]"
export NORMAL_COLOR="\[\e[m\]"

# git!

# show * for unstaged and + for uncommitted changes
export GIT_PS1_SHOWDIRTYSTATE=true

# show $ if there are stashed files
export GIT_PS1_SHOWSTASHSTATE=true

# git completion
source ~/dotfiles/git/git-completion.bash

function dir_stack {
  echo $(dirs -v            | \
         grep -v 0          | \
         sort -r            | \
         sed "s@^ @@g"      | \
         sed "s@  @@g"      | \
         sed "s@[0-9]@[&]::@" )
}

function prettify {
  echo "$1" | sed "s@\:\:@ @g"
}

function format_dirs {
  echo ""
  for DER in `dir_stack`; do
    if [ "`expr $DER : '.*\(\\/dev\/\)'`" ]; then
      echo $(prettify $DER)
    else
      echo "`echo "$(prettify $DER)" | sed "s@\:\:@ @g"` {$USER's home}"
    fi
  done
}

# setting the console prompt
export PS1="\
${CYAN}\
$(echo '$(format_dirs)')\n\
${PERIWINKLE}(\
$(echo '$(rvm-prompt)')\
$(echo '$(type __git_ps1 &>/dev/null && __git_ps1 ",\e[0;32m branch: %s\e[1;35m")')\
)\n\
${RED}\w/ ${LIGHT_CYAN}<<<${NORMAL_COLOR} "

