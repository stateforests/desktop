#!/usr/bin/env bash
set -euo pipefail

repo="$HOME/files/repositories/desktop"

sudo rsync -a --delete \
  "$repo/nixos/" \
  /etc/nixos/

rsync -a --delete \
  "$repo/dots/.config/" \
  "$HOME/.config/"

rsync -a \
  "$repo/dots/.nanorc" \
  "$HOME/.nanorc"