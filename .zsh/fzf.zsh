# fzf — GitHub Dark
# Colours are derived from the GitHub Dark palette (scripts/check-palette.py keeps them
# in sync with the rest of the theme). Without this fzf keeps its own default palette,
# which sits badly on the GitHub Dark background.

export FZF_DEFAULT_OPTS=" \
--color=bg+:#484f58,bg:#0d1117,spinner:#e3b341,hl:#ff7b72 \
--color=fg:#e6edf3,header:#ff7b72,info:#bc8cff,pointer:#e3b341 \
--color=marker:#d2a8ff,fg+:#b1bac4,prompt:#bc8cff,hl+:#ff7b72 \
--color=selected-bg:#6e7681 \
--color=border:#6e7681,label:#e6edf3 \
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
