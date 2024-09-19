#!/bin/zsh

if type nvim > /dev/null; then
  export EDITOR=nvim
  alias vim=$EDITOR
  alias en="cd $XDG_CONFIG_HOME/nvim && $EDITOR init.lua"
fi

if type lazygit > /dev/null; then
  alias lg=lazygit
fi

if type leetcode > /dev/null; then
  alias lc=leetcode
fi

if type kubectl > /dev/null; then
  alias k=kubectl
fi

if type nnn > /dev/null; then
  n() {
      nnn -de "$@"

      if [ -f $NNN_TMPFILE ]; then
          . $NNN_TMPFILE
          rm $NNN_TMPFILE
      fi
  }
fi

alias ez="cd $XDG_CONFIG_HOME/zsh/ && $EDITOR .zshrc"
