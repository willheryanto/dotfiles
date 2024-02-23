#!/bin/zsh

fo() {
  local files
  files=$(fd --type f --hidden --follow --exclude ".git"  . | fzf)
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

mkd() {
  if [[ -n $1 ]]; then
    mkdir $1 && cd $1
  fi
}

autoload edit-command-line
zle -N edit-command-line
bindkey '^X^e' edit-command-line
