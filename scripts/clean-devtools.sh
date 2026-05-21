#!/usr/bin/env bash
set -euo pipefail

pattern='[c]hrome-devtools-mcp'
dry_run=0

list_matches() {
  ps -u "$USER" -o pid=,command= | awk -v pat="$pattern" '$0 ~ pat'
}

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --dry-run|-n)
      dry_run=1
      ;;
    * )
      echo "Usage: $0 [--dry-run]" >&2
      exit 2
      ;;
  esac
  shift
done

echo "Checking Codex DevTools helper processes..."

matches="$(list_matches)"

if [[ -z "$matches" ]]; then
  echo "No matching processes found."
  exit 0
fi

echo
echo "Matched: $pattern"
echo "$matches"

if [[ "$dry_run" -eq 1 ]]; then
  echo
  echo "Dry run only. No processes were killed."
  exit 0
fi

echo
echo "Sending TERM..."
pkill -u "$USER" -TERM -f "$pattern" 2>/dev/null || true

sleep 1

leftovers="$(list_matches)"
if [[ -n "$leftovers" ]]; then
  echo "Still running after TERM:"
  echo "$leftovers"
  echo
  echo "Sending KILL..."
  pkill -u "$USER" -KILL -f "$pattern" 2>/dev/null || true
else
  echo "No matching processes left after TERM."
fi

echo "Done."
