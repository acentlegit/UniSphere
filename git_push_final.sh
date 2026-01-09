#!/bin/bash

set -e

####################################
# CONFIGURATION
####################################
REPO_URL="https://github.com/acentlegit/UniSphere.git"
BRANCH="main"
COMMIT_MSG="UniSphere: backend, frontend, docker, build-ready"
####################################

echo "🚀 UniSphere – Final Git Push Started"

####################################
# Ensure git repo
####################################
if [ ! -d ".git" ]; then
  echo "🔧 Initializing git repository"
  git init
fi

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
# Respect .gitignore (cleanup)
####################################
echo "🧹 Ensuring ignored files are not tracked"
git rm --cached -r --ignore-unmatch *.sh || true

####################################
# Re-add ONLY allowed scripts
####################################
git add \
docker_build_run.sh \
complete_backend.sh \
complete_frontend.sh \
ensure_backend_complete.sh \
git_push_final.sh \
|| true

####################################
# Add all other files
####################################
git add .

####################################
# Commit if needed
####################################
if git diff --cached --quiet; then
  echo "✔ Nothing new to commit"
else
  git commit -m "$COMMIT_MSG"
fi

####################################
# Push
####################################
echo "⬆️ Pushing to GitHub ($BRANCH)"
git push -u origin "$BRANCH"

echo ""
echo "✅ SUCCESS: UniSphere pushed to GitHub"
echo "👉 https://github.com/acentlegit/UniSphere"

