#!/usr/bin/env bash
#
# TPM entry point for tmux-anchor
#
# User-configurable options (set in ~/.tmux.conf before loading TPM):
#
#   set -g @anchor-go-1  "M-1"    # Key to open file at index 1 (default: M-1)
#   ...through...
#   set -g @anchor-go-9  "M-9"    # Key to open file at index 9 (default: M-9)
#   set -g @anchor-edit  "M-e"    # Key to edit anchor list (default: M-e)
#   set -g @anchor-switch "M-h"   # Key to open fzf switcher (default: M-h)
#
# Set any key to "none" to disable that binding.

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANCHOR="$CURRENT_DIR/scripts/anchor"

get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local value
    value=$(tmux show-option -gqv "$option")
    echo "${value:-$default_value}"
}

main() {
    # Go bindings: jump to file at index 1-9
    for i in $(seq 1 9); do
        local key
        key=$(get_tmux_option "@anchor-go-$i" "M-$i")
        if [[ "$key" != "none" ]]; then
            tmux bind-key "$key" run-shell "cd '#{pane_current_path}' && '$ANCHOR' go $i"
        fi
    done

    # Edit binding: open list in $EDITOR inside a popup
    local edit_key
    edit_key=$(get_tmux_option "@anchor-edit" "M-e")
    if [[ "$edit_key" != "none" ]]; then
        tmux bind-key "$edit_key" display-popup -E -d '#{pane_current_path}' -w 80% -h 60% "'$ANCHOR' edit"
    fi

    # Switch binding: fzf picker in a popup
    local switch_key
    switch_key=$(get_tmux_option "@anchor-switch" "M-h")
    if [[ "$switch_key" != "none" ]]; then
        tmux bind-key "$switch_key" display-popup -E -d '#{pane_current_path}' -w 80% -h 60% "'$ANCHOR' switch"
    fi
}

main
