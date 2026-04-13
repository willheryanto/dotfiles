if status is-interactive
    export EDITOR=nvim
    alias vim=$EDITOR
    alias lg=lazygit
    export MANPAGER='nvim +Man!'

    export MCFLY_FUZZY=5
    mcfly init fish | source

    zoxide init fish | source

    direnv hook fish | source
end
