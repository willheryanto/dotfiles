if type kubectl > /dev/null; then
  source <(kubectl completion zsh)
fi

if type docker > /dev/null; then
  if [[ -f $XDG_CONFIG_HOME/zsh/completions/_docker ]]; then
    source $XDG_CONFIG_HOME/zsh/completions/_docker
  fi
fi

if type gh > /dev/null; then
  if [[ -f $XDG_CONFIG_HOME/zsh/completions/_gh ]]; then
    source $XDG_CONFIG_HOME/zsh/completions/_gh
  fi
fi
