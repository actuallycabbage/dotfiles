#!/usr/bin/env bash
set -eu

# NUL delimiters preserve spaces and newlines in filenames; Escape pastes nothing.
IFS= read -r -d '' file < <(
    git ls-files --cached --others --exclude-standard -z -- . |
        fzf --read0 --print0 --no-multi --reverse --prompt='Files > '
) || exit 0

# A private buffer avoids cross-client races. No trailing newline means no Enter.
buffer="file-picker-$$"
tmux set-buffer -b "$buffer" -- "$file"
tmux paste-buffer -d -p -r -b "$buffer" -t "$1"
