#!/bin/bash
set -euo pipefail

if [ "$#" -lt 3 ]; then
  echo "Usage: $0 SOURCE_WORKTREE DEST_WORKTREE TARGET..." >&2
  exit 1
fi

source_worktree=$(cd "$1" && pwd -P)
cd "$2"
shift 2

if [ "$source_worktree" -ef . ]; then
  exit 0
fi

for target in "$@"; do
  case "$target" in
    ''|/*|..|../*|*/../*|*/..|.|./)
      echo "Target must be a relative path within the worktree: $target" >&2
      exit 1
      ;;
  esac

  source_path="$source_worktree/$target"
  if [ ! -e "$source_path" ] || [ -e "./$target" ] || [ -L "./$target" ]; then
    continue
  fi

  # Seed only once: later starts must preserve the worktree's independent state.
  # macOS clones share APFS storage until written; cp falls back on other filesystems.
  mkdir -p "$(dirname "./$target")"
  /bin/cp -Rc "$source_path" "./$target"
done
