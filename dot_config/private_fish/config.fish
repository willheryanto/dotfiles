if status is-interactive
    export EDITOR=nvim
    alias vim=$EDITOR

    alias lg=lazygit
    alias lc=leetcode

    alias k=kubectl

    export PSQL_PAGER="pspg -X -b"

end

zoxide init fish | source

if test -e $HOME/.env
    export $(cat $HOME/.env | xargs -L 1)
end
