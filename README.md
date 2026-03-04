# dotfiles

Personal dotfiles for zsh, tmux, iterm2, and vim.

## Contents

- `zsh/zshrc` — full personal zsh config
- `zsh/ec_zshrc` — shared EC team zsh config (aliases, tmux pane titles)
- `tmux/tmux.conf` — tmux config
- `vim/vimrc` — vim config
- `iterm2/` — iTerm2 preferences

## Structure

```
dotfiles/
├── install.sh
├── zsh/
│   ├── zshrc
│   └── ec_zshrc
├── tmux/
│   └── tmux.conf
├── vim/
│   └── vimrc
└── iterm2/
    ├── com.googlecode.iterm2.plist
    └── com.googlecode.iterm2.private.plist
```

## Install

> **Note:** These dotfiles are designed for macOS.

### Prerequisites

Install dependencies via Homebrew before running the install script. If you don't have Homebrew, install it first at [brew.sh](https://brew.sh).

```bash
brew install tmux
brew install --cask iterm2
```

### Setup

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh [options]
```

### Options

| Flag | Description |
|---|---|
| `--zsh` | Install zsh config |
| `--tmux` | Install tmux config |
| `--vim` | Install vim config |
| `--all` | Install everything |
| `--ec` | Use the shared EC zsh config instead of the full personal one |
| `--append` | Append a `source` line to your existing `~/.zshrc` instead of symlinking over it (zsh only) |

### Personal machine

```bash
./install.sh --all
```

Symlinks `zshrc` → `~/.zshrc`, `tmux.conf` → `~/.tmux.conf`, `vimrc` → `~/.vimrc`. Backs up any existing files before overwriting.

### Teammate / EC install

```bash
./install.sh --zsh --ec --append --tmux
```

- Symlinks `ec_zshrc` → `~/.ec_zshrc`
- Appends `source ~/.ec_zshrc  # EC dotfiles` to your existing `~/.zshrc` (non-destructive, idempotent)
- Symlinks `tmux.conf` → `~/.tmux.conf`

Your existing `~/.zshrc` and oh-my-zsh setup are left intact.
