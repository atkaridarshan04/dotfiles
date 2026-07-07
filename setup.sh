#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOME_DIR="$HOME"

echo "Using dotfiles from:"
echo "$DOTFILES_DIR"

backup_file() {
    local file="$1"

    if [ -e "$HOME_DIR/$file" ] || [ -L "$HOME_DIR/$file" ]; then
        if [ ! -L "$HOME_DIR/$file" ]; then
            echo "Backing up $file"
            mv "$HOME_DIR/$file" "$HOME_DIR/${file}.backup.$(date +%Y%m%d%H%M%S)"
        else
            rm "$HOME_DIR/$file"
        fi
    fi
}

link_file() {
    local source="$1"
    local target="$2"

    backup_file "$target"

    echo "Linking $target"

    ln -s "$DOTFILES_DIR/$source" "$HOME_DIR/$target"
}


echo ""
echo "Creating directories..."

mkdir -p "$HOME_DIR/.config"


echo ""
echo "Linking zsh configuration..."

link_file ".zshrc" ".zshrc"
link_file ".zsh" ".zsh"


echo ""
echo "Linking Starship configuration..."

link_file ".config/starship.toml" ".config/starship.toml"


echo ""
echo "Linking Warp configuration..."

if [ -d "$DOTFILES_DIR/.warp" ]; then
    link_file ".warp" ".warp"
fi


echo ""
echo "VS Code settings..."

if [[ "$OSTYPE" == "darwin"* ]]; then

    VSCODE_PATH="$HOME_DIR/Library/Application Support/Code/User"

    mkdir -p "$VSCODE_PATH"

    if [ -f "$DOTFILES_DIR/vscode/settings.json" ]; then
        backup_file "Library/Application Support/Code/User/settings.json"

        ln -s \
        "$DOTFILES_DIR/vscode/settings.json" \
        "$VSCODE_PATH/settings.json"

        echo "VS Code settings linked"
    fi

fi


# echo ""
# echo "Installing Homebrew packages..."

# if command -v brew >/dev/null 2>&1; then
#     brew bundle --file="$DOTFILES_DIR/Brewfile"
# else
#     echo "Homebrew not found. Skipping Brewfile."
# fi


echo ""
echo "Setup completed!"
echo ""
echo "Restart your shell:"
echo "exec zsh"
