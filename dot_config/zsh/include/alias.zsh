#!/bin/zsh

if type nvim > /dev/null; then
  export EDITOR=nvim
  alias vim=$EDITOR
  alias en="cd $XDG_CONFIG_HOME/nvim && $EDITOR init.lua"
fi

if type lsd > /dev/null; then
  alias ls=lsd
fi

if type lazygit > /dev/null; then
  alias lg=lazygit
fi

if type leetcode > /dev/null; then
  alias lc=leetcode
fi

# if type nnn > /dev/null; then
#   alias n=nnn
#
#   function nnn() {
#     command nnn -e "$@"
#   }
# fi


if type kubectl > /dev/null; then
  alias k=kubectl
fi

alias ez="cd $XDG_CONFIG_HOME/zsh/ && $EDITOR .zshrc"
