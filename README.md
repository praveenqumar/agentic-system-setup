# agentic-system-setup

Personal macOS setup/recovery scripts.

## Install

```bash
git clone https://github.com/praveenqumar/agentic-system-setup.git
cd agentic-system-setup
./install.sh
source ~/.zshrc
```

If SSH is configured:

```bash
git clone git@github.com:praveenqumar/agentic-system-setup.git
```

## Included

### `spotlight-noindex`

Prevent Spotlight indexing for a folder by adding `.metadata_never_index`.

```bash
spotlight-noindex /path/to/folder
spotlight-noindex /Volumes/SmartJoules/project/node_modules
```

### Awake helpers

Use macOS built-in `caffeinate` in the background.

```bash
awake        # keep awake until stopped
awake1h      # keep awake for 1 hour
awake2h      # keep awake for 2 hours
awake-status # check status
awake-stop   # stop
```

## Files

```text
scripts/spotlight-noindex
shell/zsh-awake.zsh
ai/spotlight-noindex-global-instructions.md
install.sh
```
