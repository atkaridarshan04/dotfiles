# fzf — Dark+
# Colours are derived from the Dark+ palette (scripts/check-palette.py keeps them
# in sync with the rest of the theme). Without this fzf keeps its own default palette,
# which sits badly on the Dark+ background.

export FZF_DEFAULT_OPTS=" \
--color=bg+:#264f78,bg:#1e1e1e,spinner:#f5f543,hl:#cd3131 \
--color=fg:#d4d4d4,header:#cd3131,info:#bc3fbc,pointer:#f5f543 \
--color=marker:#d670d6,fg+:#d4d4d4,prompt:#bc3fbc,hl+:#cd3131 \
--color=selected-bg:#666666 \
--color=border:#666666,label:#d4d4d4 \
--height=60% --layout=reverse --border=rounded --info=inline"

# Use fd for traversal when available: respects .gitignore and skips .git.
if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
fi

# Previews, themed to match.
if command -v bat >/dev/null 2>&1; then
    export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {}'"
fi
if command -v eza >/dev/null 2>&1; then
    export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --icons --color=always {}'"
fi
