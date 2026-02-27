#!/usr/bin/env bash

set -euo pipefail

#######################################
# Defaults
#######################################

INSTALL_ZSH=false
INSTALL_TMUX=false
INSTALL_VIM=false
INSTALL_ALL=false

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
  --help       Show this help message

Examples:
  ./install.sh --tmux --vim
  ./install.sh --all
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
  echo "Installing zsh config..."
  link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
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