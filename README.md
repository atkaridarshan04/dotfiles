# Dotfiles

Personal configuration files for my development environment.

This repository contains my shell, terminal, editor, and tool configurations that I use across machines.

---

## Structure

```
.
├── .config
│   └── starship.toml
├── .warp
│   └── themes
├── .zsh
│   ├── aliases.zsh
│   ├── functions.zsh
│   ├── nvm.zsh
│   └── starship.zsh
├── .zshrc
├── Brewfile
├── README.md
└── vscode
    └── settings.json
```

---

## Setup

Clone the repository:

```bash
git clone <repo-url>
cd dotfiles
````

Install packages:

```bash
brew bundle
```

## Copy configuration files to home directory:

```bash
cp .zshrc ~/.zshrc
cp -R .zsh ~/.zsh
```

```bash
mkdir -p ~/.config
cp .config/starship.toml ~/.config/starship.toml
```

```bash
cp -R .warp ~/.warp
```

VS Code settings:

```bash
cp vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
```

Reload shell:

```bash
source ~/.zshrc
```

---

## Backup

Before replacing existing files, backup current configurations.

Example:

```bash
cp ~/.zshrc ~/.zshrc.backup
```

---
