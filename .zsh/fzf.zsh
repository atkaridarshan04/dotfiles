# fzf — One Dark Pro
# Colours are derived from the One Dark Pro palette (scripts/check-palette.py keeps them
# in sync with the rest of the theme). Without this fzf keeps its own default palette,
# which sits badly on the One Dark background.

export FZF_DEFAULT_OPTS=" \
--color=bg+:#3f4451,bg:#23272e,spinner:#f0a45d,hl:#e05561 \
--color=fg:#abb2bf,header:#e05561,info:#c162de,pointer:#f0a45d \
--color=marker:#de73ff,fg+:#d7dae0,prompt:#c162de,hl+:#e05561 \
--color=selected-bg:#4f5666 \
--color=border:#4f5666,label:#abb2bf \
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
