#!/bin/bash

# Install zsh
sudo apt install -y zsh

# Set zsh as the default shell for the current user (idempotent)
ZSH_BIN="$(command -v zsh)"
if [ -n "$ZSH_BIN" ]; then
  # Ensure zsh is listed as a valid login shell
  if ! grep -qx "$ZSH_BIN" /etc/shells; then
    echo "$ZSH_BIN" | sudo tee -a /etc/shells >/dev/null
  fi

  if [ "$SHELL" != "$ZSH_BIN" ]; then
    sudo chsh -s "$ZSH_BIN" "$USER"
  fi
fi
