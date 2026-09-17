#!/usr/bin/env bash
set -euo pipefail

repo="$HOME/files/repositories/desktop"

sudo rsync -a --delete \
  "$repo/nixos/" \
  /etc/nixos/

rsync -a \
  "$repo/dotfiles/.config/" \
  "$HOME/.config/"

rsync -a \
  "$repo/dotfiles/.nanorc" \
  "$HOME/.nanorc"