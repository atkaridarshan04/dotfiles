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

# Autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting (must be last)
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
