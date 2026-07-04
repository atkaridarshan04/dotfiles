# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Custom configs
for file in ~/.zsh/*.zsh; do
  [[ -f "$file" ]] && source "$file"
done

# Completion
autoload -Uz compinit
compinit

# zoxide
eval "$(zoxide init zsh)"

# fzf
source <(fzf --zsh)

# Starship
eval "$(starship init zsh)"
