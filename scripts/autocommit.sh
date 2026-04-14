#!/usr/bin/env bash
set -euo pipefail
cd /root/wikis/Bridge

# Stage tracked + untracked content (respecting .gitignore)
git add -A

# Commit only when there are staged changes
if ! git diff --cached --quiet; then
  git commit -m "vault: auto-commit $(date -u +'%Y-%m-%d %H:%M UTC')"
fi
