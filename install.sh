#!/usr/bin/env bash

set -euo pipefail

#######################################
# Defaults
#######################################

INSTALL_ZSH=false
INSTALL_TMUX=false
INSTALL_VIM=false
INSTALL_ALL=false
EC_MODE=false
APPEND_MODE=false

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#######################################
# Help
#######################################

usage() {
  cat <<EOF
Usage: ./install.sh [options]

Options:
  --zsh        Install zsh config
  --tmux       Install tmux config
  --vim        Install vim config
  --all        Install everything
  --ec         Use the EC shared zsh config (ec_zshrc) instead of the full personal zshrc
  --append     Append a source line to existing ~/.zshrc instead of symlinking over it (zsh only)
  --help       Show this help message

Examples:
  ./install.sh --tmux --vim
  ./install.sh --all
  ./install.sh --zsh --ec --append    # teammate-safe: keeps existing ~/.zshrc, sources EC config
EOF
  exit 0
}

#######################################
# Parse Arguments
#######################################

if [[ $# -eq 0 ]]; then
  usage
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --zsh) INSTALL_ZSH=true ;;
    --tmux) INSTALL_TMUX=true ;;
    --vim) INSTALL_VIM=true ;;
    --all) INSTALL_ALL=true ;;
    --ec) EC_MODE=true ;;
    --append) APPEND_MODE=true ;;
    --help) usage ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
  shift
done

if $INSTALL_ALL; then
  INSTALL_ZSH=true
  INSTALL_TMUX=true
  INSTALL_VIM=true
fi

#######################################
# Utilities
#######################################

backup_if_exists() {
  local target="$1"

  if [[ -e "$target" || -L "$target" ]]; then
    local backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backing up $target → $backup"
    mv "$target" "$backup"
  fi
}

link_file() {
  local source="$1"
  local target="$2"

  backup_if_exists "$target"

  echo "Linking $source → $target"
  ln -s "$source" "$target"
}

#######################################
# Installations
#######################################

install_zsh() {
  if $APPEND_MODE; then
    local source_file target_name source_line

    if $EC_MODE; then
      source_file="$DOTFILES_DIR/zsh/ec_zshrc"
      target_name="$HOME/.ec_zshrc"
      source_line="source ~/.ec_zshrc  # EC dotfiles"
    else
      source_file="$DOTFILES_DIR/zsh/zshrc"
      target_name="$HOME/.my_zshrc"
      source_line="source ~/.my_zshrc  # EC dotfiles"
    fi

    echo "Installing zsh config (append mode)..."
    link_file "$source_file" "$target_name"

    if [[ ! -f "$HOME/.zshrc" ]]; then
      touch "$HOME/.zshrc"
    fi

    if grep -qF "$source_line" "$HOME/.zshrc"; then
      echo "Source line already present in ~/.zshrc, skipping."
    else
      echo "" >> "$HOME/.zshrc"
      echo "$source_line" >> "$HOME/.zshrc"
      echo "Appended '$source_line' to ~/.zshrc"
    fi
  else
    echo "Installing zsh config..."
    if $EC_MODE; then
      link_file "$DOTFILES_DIR/zsh/ec_zshrc" "$HOME/.zshrc"
    else
      link_file "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
    fi
  fi
}

install_tmux() {
  echo "Installing tmux config..."
  link_file "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
}

install_vim() {
  echo "Installing vim config..."
  link_file "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"
}

#######################################
# Execute Selected Installs
#######################################

$INSTALL_ZSH && install_zsh
$INSTALL_TMUX && install_tmux
$INSTALL_VIM && install_vim

echo "Installation complete."