# Dotfiles

Personal configuration for shell, terminal, editor and tools, themed with Catppuccin Mocha.

---

## Structure

```
.
├── .config
│   ├── bat/config
│   ├── ghostty/config
│   └── starship.toml
├── .warp/themes
├── .zsh
│   ├── aliases.zsh
│   ├── env.zsh
│   ├── functions.zsh
│   ├── fzf.zsh
│   └── history.zsh
├── .zshrc
├── Brewfile
├── Makefile
├── install.sh
├── iterm2
│   ├── Catppuccin-Mocha.json
│   └── catppuccin-mocha.itermcolors
├── scripts/check-palette.py
└── vscode/settings.json
```

Run `make check` to validate shell syntax, the starship and Ghostty configs, the iTerm2 profile and palette consistency.

---

## Setup

```bash
git clone <repo-url> ~/personal/dotfiles
cd ~/personal/dotfiles
brew bundle
./install.sh
exec zsh
```

`install.sh` symlinks each file into place and backs up anything it replaces to `<path>.backup.<timestamp>`. Re-running is safe.

Then:

- **iTerm2** — Settings → Profiles → *Catppuccin Mocha* → set as default.
- **VS Code** — install the *Catppuccin for VSCode* extension.

---

## Theme

Catppuccin Mocha across every surface:

| Surface | File |
|---|---|
| Ghostty | `.config/ghostty/config` |
| iTerm2 | `iterm2/Catppuccin-Mocha.json`, `iterm2/catppuccin-mocha.itermcolors` |
| Starship | `.config/starship.toml` |
| fzf | `.zsh/fzf.zsh` |
| bat | `.config/bat/config` |
| VS Code | `vscode/settings.json` |

Requires a Nerd Font for the prompt glyphs; `brew bundle` installs JetBrains Mono Nerd Font.

---

## Prompt

Starship, configured in `.config/starship.toml`:

```
󱃾 mvue-non-prod-eks (us-west-2) (monitor-security)   ~/dotfiles on  main [!4?6]
󰞏 PROD payments-prod-eks (eu-central-1)              ~/dotfiles on  main [!4?6]
󰞏 PROD kubernetes-admin@prod-cluster (kube-system)   ~/dotfiles on  main [!4?6]
󰡨 docker-desktop                                     ~/dotfiles on  main [!4?6]
```

`[[kubernetes.contexts]]` shortens the context and colours it by environment: dimmed grey for local, teal for non-prod, bold red with a `󰞏 PROD` marker for production. Entries are matched in order, first match wins.

The AWS segment shows the active profile, region and credential expiry.
