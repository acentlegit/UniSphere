#!/bin/bash

set -e

echo "🧹 Cleaning UniSphere repository..."

# Remove macOS junk
rm -f .DS_Store

# Remove ZIP artifacts
rm -f *.zip

# Remove temporary setup scripts
rm -f complete_backend.sh
rm -f complete_frontend.sh
rm -f ensure_backend_complete.sh
rm -f git_push_final.sh
rm -f git_recover_and_push.sh
rm -f push_unisphere.sh
rm -f docker_build_run.sh

# Remove accidental nested folder
rm -rf UniSphere

echo "✅ Cleanup complete"

echo "📦 Remaining structure:"
ls -1

echo "➡️ Next: commit & push"

