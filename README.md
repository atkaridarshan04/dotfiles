# Dotfiles

Personal configuration files for my development environment.

This repository contains my shell, terminal, editor, and tool configurations that I use across machines.

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

Link configuration files:

```bash
./setup.sh
```

Restart the terminal:

```bash
exec zsh
```

---

## Backup

Before replacing existing files, backup current configurations.

Example:

```bash
cp ~/.zshrc ~/.zshrc.backup
```

---
