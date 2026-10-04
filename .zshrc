# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Custom configs
if [[ -d "$HOME/.zsh" ]]; then
    for file in "$HOME/.zsh"/*.zsh; do
        [[ -f "$file" ]] && source "$file"
    done
fi

# Completion
# Regenerate the completion dump once a day instead of on every shell: the glob below
# matches only if .zcompdump is less than a day old, in which case compinit skips its
# (slow) security check with -C.
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh-24) ]]; then
    compinit -C
else
    compinit
fi

# zoxide
eval "$(zoxide init zsh)"

# fzf
source <(fzf --zsh)

# Autosuggestions
if [[ -f "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Starship
eval "$(starship init zsh)"

# Syntax highlighting (must be last)
if [[ -f "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
