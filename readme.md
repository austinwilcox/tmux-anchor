# tmux-anchor

A tmux file navigator inspired by [ThePrimeagen's harpoon](https://github.com/ThePrimeagen/harpoon) for Neovim. Quickly bookmark and jump to files you're working on, scoped per project directory.

## Install

### With [TPM](https://github.com/tmux-plugins/tpm)

Add to your `~/.tmux.conf`:

```tmux
set -g @plugin 'austinwilcox/tmux-anchor'
```

Then press `prefix + I` to install.

### Standalone

```bash
./install.sh            # installs to ~/.local/bin
./install.sh /usr/local/bin  # or a custom directory
```

Make sure the install directory is in your `PATH`.

## Usage

```
anchor add <file>        Add a file to the anchor list
anchor rm <file|index>   Remove a file by path or 1-based index
anchor list              Show all anchored files
anchor go <index>        Open file at index in $EDITOR via tmux
anchor edit              Open the anchor list in $EDITOR to reorder/prune
anchor switch            Interactive fzf picker (requires fzf)
anchor clear             Clear all anchored files
```

## Default Keybindings (TPM)

| Key | Action |
|-----|--------|
| `Alt+1` through `Alt+9` | Jump to file at index 1-9 |
| `Alt+e` | Edit the anchor list in a popup |
| `Alt+h` | Open the fzf switcher in a popup |

All keybindings are configurable. Set any key to `"none"` to disable it:

```tmux
set -g @anchor-go-1   "M-1"    # default
set -g @anchor-go-2   "M-2"    # default
set -g @anchor-edit   "M-e"    # default
set -g @anchor-switch "M-h"    # default
set -g @anchor-go-5   "none"   # disable Alt+5
```

## How It Works

- File lists are stored per-project in `~/.config/anchor/`, keyed by an MD5 hash of the working directory
- Lists persist across tmux sessions and machine restarts
- The `ANCHOR_DIR` environment variable overrides the default storage location
- The `EDITOR` environment variable controls which editor is used (default: `vim`)

## Requirements

- tmux
- `fzf` (only required for the `switch` command)
