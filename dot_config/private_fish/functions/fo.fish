function fo
    set files (command fd --type f --hidden --follow --exclude ".git" . | fzf)
    if test -n "$files"
        if test -n "$EDITOR"
            eval $EDITOR $files[1]
        else
            vim $files[1]
        end
    end
end
