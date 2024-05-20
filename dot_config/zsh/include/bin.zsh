export PATH="$PATH:$HOME/.config/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
if type brew &>/dev/null; then
  export PATH="$PATH:$(brew --prefix)/opt/libpq/bin"
fi

if type tfswitch &>/dev/null; then
  export PATH="$PATH:$HOME/bin"
fi
