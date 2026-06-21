#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bin_dir="$HOME/.local/bin"
config_dir="$HOME/.config/agentic-system-setup"
zshrc="$HOME/.zshrc"

mkdir -p "$bin_dir" "$config_dir"

install -m 0755 "$repo_dir/scripts/spotlight-noindex" "$bin_dir/spotlight-noindex"
install -m 0644 "$repo_dir/shell/zsh-awake.zsh" "$config_dir/zsh-awake.zsh"

touch "$zshrc"

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$zshrc"; then
  cat >> "$zshrc" <<'EOF'

# User scripts
export PATH="$HOME/.local/bin:$PATH"
EOF
fi

if ! grep -q 'agentic-system-setup/zsh-awake.zsh' "$zshrc"; then
  cat >> "$zshrc" <<'EOF'

# Agentic system setup: awake helpers
[ -f "$HOME/.config/agentic-system-setup/zsh-awake.zsh" ] && source "$HOME/.config/agentic-system-setup/zsh-awake.zsh"
EOF
fi

instruction_file="$repo_dir/ai/spotlight-noindex-global-instructions.md"
instruction_block="$(cat "$instruction_file")"

add_instruction_once() {
  local target="$1"
  mkdir -p "$(dirname "$target")"
  touch "$target"
  if ! grep -q 'macOS Spotlight no-index workflow' "$target"; then
    tmp="$(mktemp)"
    {
      cat "$instruction_file"
      printf '\n'
      cat "$target"
    } > "$tmp"
    mv "$tmp" "$target"
  fi
}

add_instruction_once "$HOME/.claude/CLAUDE.md"
add_instruction_once "$HOME/.codex/AGENTS.md"

cat <<EOF
Installed:
- $bin_dir/spotlight-noindex
- $config_dir/zsh-awake.zsh

Updated:
- $zshrc
- $HOME/.claude/CLAUDE.md
- $HOME/.codex/AGENTS.md

Next:
  source ~/.zshrc

Commands:
  spotlight-noindex /path/to/folder
  awake
  awake1h
  awake2h
  awake-status
  awake-stop
EOF
