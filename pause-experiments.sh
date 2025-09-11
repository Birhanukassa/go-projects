#!/bin/bash

# Pause Experiments - Stop syncing test-experiments branch

echo "⏸️ Pausing experiment syncing..."

# Create local pause flag
touch /tmp/pause-experiments

# Create GitHub Actions pause flag (if in git repo)
if git rev-parse --git-dir > /dev/null 2>&1; then
    touch .pause-experiments
    git add .pause-experiments
    git commit -m "Pause experiments syncing"
    git push origin master
    echo "✅ GitHub Actions will skip test-experiments sync"
fi

echo "✅ Local sync will skip test-experiments sync"
echo "📝 To resume: ./resume-experiments.sh"