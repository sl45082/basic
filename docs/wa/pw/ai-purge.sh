#!/bin/bash
set -euo pipefail

# 👁️ Configure paths to remove and branch name
TARGET_BRANCH="main"
PURGE_PATHS=("*.bin" "assets/cache/")  # Modify as needed
BACKUP_REMOTE="origin"

# 🧭 Ensure we’re inside a Git repo
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "❌ Not inside a Git repository."
  exit 1
fi

# 🔗 Save remote URL in case it's wiped
REMOTE_URL=$(git config --get remote.${BACKUP_REMOTE}.url || true)
if [[ -z "$REMOTE_URL" ]]; then
  echo "❌ Could not determine remote URL."
  exit 1
fi

# 🪖 Clone mirror into temp dir for filter-repo
TEMP_DIR=$(mktemp -d)
echo "📦 Cloning mirror to $TEMP_DIR..."
git clone --mirror . "$TEMP_DIR"
cd "$TEMP_DIR"

# 🔍 Build filter-repo path args
FILTER_ARGS=()
for path in "${PURGE_PATHS[@]}"; do
  FILTER_ARGS+=(--path "$path")
done

# 🔥 Rewrite history using --invert-paths
echo "🧹 Running git filter-repo to remove paths..."
if ! git filter-repo "${FILTER_ARGS[@]}" --invert-paths --force; then
  echo "❌ Filter-repo failed."
  exit 1
fi

# 🧼 Garbage collection to shrink repo
echo "🧽 Cleaning up with aggressive GC..."
git reflog expire --expire=now --all || echo "⚠️ reflog expire failed"
git gc --prune=now --aggressive || echo "⚠️ gc failed"

# 🔌 Reconnect remote if wiped
if ! git config remote.${BACKUP_REMOTE}.url > /dev/null 2>&1; then
  git remote add ${BACKUP_REMOTE} "$REMOTE_URL"
fi

# 🚀 Force-push rewritten history
echo "🚀 Pushing cleaned repo to $BACKUP_REMOTE/$TARGET_BRANCH..."
if ! git push --force --progress "$BACKUP_REMOTE" "refs/heads/$TARGET_BRANCH"; then
  echo "❌ Push failed. Retrying with chunked commits..."
  git push --force "$BACKUP_REMOTE" "$TARGET_BRANCH" || {
    echo "❌ All push attempts failed."
    exit 1
  }
fi

echo "✅ History rewrite and push complete."

