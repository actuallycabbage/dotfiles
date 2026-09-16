#!/bin/bash
set -euo pipefail

if [ "$#" -lt 3 ]; then
  echo "Usage: $0 SOURCE_WORKTREE DEST_WORKTREE DIRECTORY..." >&2
  exit 1
fi

source_worktree=$(cd "$1" && pwd -P)
cd "$2"
shift 2

# The primary checkout owns shared directories; it must never link to itself.
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

  if [ -e "./$target" ] || [ -L "./$target" ]; then
    continue
  fi

  # Create the authoritative directory even before the first build populates it.
  mkdir -p "$source_worktree/$target" "$(dirname "./$target")"
  ln -s "$source_worktree/$target" "./$target"
done
