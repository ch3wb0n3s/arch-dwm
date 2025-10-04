#!/usr/bin/env bash
set -euo pipefail

# Install deps for building/running dwm
sudo pacman -Syu --noconfirm --needed base-devel

# Ensure we operate from ~/.local/src/arch-dwm
cd ~/.local/src/arch-dwm

# Vendor dwm (clone into ./dwm and remove its .git), or just build if present
if [[ ! -d dwm ]]; then
  git clone --depth=1 https://git.suckless.org/dwm dwm
  rm -rf dwm/.git
fi

# Ensure xinit starts dwm (append only once)
if ! grep -qx 'exec dwm' "$HOME/.xinitrc" 2>/dev/null; then
  echo "exec dwm" >> "$HOME/.xinitrc"
fi

cd dwm
make
sudo make install