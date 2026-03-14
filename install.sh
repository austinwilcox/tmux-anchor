#!/usr/bin/env bash
# Install anchor to ~/.local/bin
set -euo pipefail

INSTALL_DIR="${1:-$HOME/.local/bin}"

mkdir -p "$INSTALL_DIR"
cp "$(dirname "$0")/scripts/anchor" "$INSTALL_DIR/anchor"
chmod +x "$INSTALL_DIR/anchor"

echo "Installed anchor to $INSTALL_DIR/anchor"
echo ""
echo "Make sure $INSTALL_DIR is in your PATH."
echo "Run 'anchor bind' to see suggested tmux keybindings."
