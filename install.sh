#!/usr/bin/env bash
#
# Symlink dotfiles into place.
#
# Symlinks, not copies: with a copy, editing the repo does nothing until you remember to
# re-run the install, and editing the live file silently drifts from what git tracks.
# Anything already present and not already pointing at this repo is moved aside to
# <path>.backup.<timestamp> rather than overwritten.

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

info() { printf '\033[1;34m==>\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$1"; }

link() {
    local src="$1" dst="$2"

    if [[ ! -e "$src" ]]; then
        warn "missing in repo, skipping: $src"
        return
    fi

    mkdir -p "$(dirname "$dst")"

    # Already correct -- nothing to do.
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        printf '    ok   %s\n' "$dst"
        return
    fi

    if [[ -e "$dst" || -L "$dst" ]]; then
        mv "$dst" "$dst.backup.$STAMP"
        warn "backed up existing $dst -> $dst.backup.$STAMP"
    fi

    ln -s "$src" "$dst"
    printf '    link %s -> %s\n' "$dst" "$src"
}

info "Shell"
link "$REPO/.zshrc"                         "$HOME/.zshrc"
link "$REPO/.zsh"                           "$HOME/.zsh"

info "Starship"
link "$REPO/.config/starship.toml"          "$HOME/.config/starship.toml"

info "Ghostty"
link "$REPO/.config/ghostty/config"         "$HOME/.config/ghostty/config"

info "bat"
# No theme file is vendored here: bat bundles Coldark-Dark out of the box,
# so the config just selects it. Nothing to compile, no `bat cache --build`.
link "$REPO/.config/bat/config"             "$HOME/.config/bat/config"

info "iTerm2"
# COPY, not symlink. iTerm2 reloads dynamic profiles when the *directory contents* change;
# rewriting a symlink's target does not change the directory, so a symlink would never
# trigger a reload -- and a profile that silently fails to refresh is worse than one you
# knowingly re-copy. Cost: re-run this script after editing the profile in the repo.
ITERM_DP="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
mkdir -p "$ITERM_DP"
for old in Catppuccin-Mocha.json One-Dark-Pro.json; do
    if [[ -e "$ITERM_DP/$old" ]]; then
        rm "$ITERM_DP/$old"   # clean up the profile from an earlier theme
    fi
done
if [[ -L "$ITERM_DP/GitHub-Dark.json" ]]; then
    rm "$ITERM_DP/GitHub-Dark.json"   # clean up a symlink from an earlier run
fi
cp "$REPO/iterm2/GitHub-Dark.json" "$ITERM_DP/GitHub-Dark.json"
printf '    copy %s\n' "$ITERM_DP/GitHub-Dark.json"

info "VS Code"
link "$REPO/vscode/settings.json" \
     "$HOME/Library/Application Support/Code/User/settings.json"

echo
info "Done. Open a new shell, or: exec zsh"
echo "    iTerm2:  Preferences > Profiles > 'GitHub Dark' (set as default)"
echo "    VS Code: install the 'GitHub Theme' extension, select the 'GitHub Dark Default' theme"
