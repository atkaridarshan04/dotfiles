# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Custom configs
if [[ -d "$HOME/.zsh" ]]; then
    for file in "$HOME/.zsh"/*.zsh; do
        [[ -f "$file" ]] && source "$file"
    done
fi

# Completion
autoload -Uz compinit
compinit

# zoxide
eval "$(zoxide init zsh)"

# fzf
source <(fzf --zsh)

# Autosuggestions
if [[ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Starship
eval "$(starship init zsh)"

# Syntax highlighting (must be last)
if [[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
