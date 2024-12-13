if status is-interactive
    export EDITOR=nvim
    alias vim=$EDITOR

    alias lg=lazygit
    alias lc=leetcode

    alias k=kubectl

    export PSQL_PAGER="pspg -X -b"

    zoxide init fish | source

    source $(brew --prefix asdf)/libexec/asdf.fish

end
