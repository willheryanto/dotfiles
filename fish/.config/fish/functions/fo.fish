function fo
    if not type -q fd
        echo "fo: missing dependency: fd" >&2
        return 127
    end
    if not type -q fzf
        echo "fo: missing dependency: fzf" >&2
        return 127
    end

    set -l query (string join -- " " $argv)
    set -l fzf_args \
        --exit-0 \
        --height=80% \
        --layout=reverse \
        --border \
        --prompt='fo> ' \
        --info=inline \
        --preview='bat --style=numbers --color=always --line-range :200 {}' \
        --preview-window='right,60%,wrap'
    if test -n "$query"
        set -a fzf_args --query "$query"
    end

    set -l file (command fd --type f --hidden --follow --exclude ".git" . | fzf $fzf_args)
    test -n "$file"; or return 0

    set -l editor $VISUAL
    if test -z "$editor"
        set editor $EDITOR
    end

    if test -n "$editor"
        set -l editor_cmd (string split -- " " $editor)
        if not type -q -- $editor_cmd[1]
            echo "fo: editor not found: $editor_cmd[1]" >&2
            return 127
        end
        command $editor_cmd -- "$file"
        return $status
    end

    command vim -- "$file"
end
