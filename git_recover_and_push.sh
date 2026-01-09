#!/bin/bash

set -e

####################################
# CONFIG
####################################
REPO_URL="https://github.com/acentlegit/UniSphere.git"
BRANCH="main"
COMMIT_MSG="UniSphere: backend, frontend, docker, build-ready"
####################################

echo "🚀 UniSphere Git Recovery + Push Started"

####################################
# Abort any ongoing rebase
####################################
if git status | grep -q "rebase in progress"; then
  echo "⚠️ Rebase detected — aborting"
  git rebase --abort
fi

####################################
# Clean conflict artifacts
####################################
echo "🧹 Removing conflict artifacts"
rm -rf frontend~*

####################################
# Ensure correct branch
####################################
git branch -M "$BRANCH"

####################################
# Ensure remote
####################################
if git remote | grep -q origin; then
  echo "✔ Remote origin exists"
else
  echo "🔗 Adding remote origin"
  git remote add origin "$REPO_URL"
fi

####################################
# Fix frontend tracking
####################################
echo "📁 Fixing frontend directory tracking"
git rm --cached -r frontend || true
git add frontend

####################################
# Stage everything
####################################
echo "📦 Staging all files"
git add .

####################################
# Commit
####################################
echo "📝 Committing"
git commit -m "$COMMIT_MSG"

####################################
# Force push (intentional reset)
####################################
echo "⬆️ Force pushing to GitHub"
git push origin "$BRANCH" --force

echo ""
echo "✅ SUCCESS: Repository fully recovered and pushed"
echo "👉 https://github.com/acentlegit/UniSphere"

