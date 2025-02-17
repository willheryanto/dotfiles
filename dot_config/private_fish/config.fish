if status is-interactive
    export EDITOR=nvim
    alias vim=$EDITOR

    alias lg=lazygit
    alias lc=leetcode

    alias k=kubectl

    export PSQL_PAGER="pspg -X -b"

    zoxide init fish | source

    source $(brew --prefix asdf)/libexec/asdf.fish
    set -gx PATH ~/.asdf/shims $PATH # I don't know why, but this ensuring sub shell have the asdf as top priority
    mcfly init fish | source
end
