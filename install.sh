#!/usr/bin/env bash

DOTFILES_DIR="$HOME/dotfiles"

echo "Creating symlinks..."

ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/vim/vimrc" "$HOME/.vimrc"

echo "Done."

