#!/bin/bash

# Resume Experiments - Restart syncing test-experiments branch

echo "▶️ Resuming experiment syncing..."

# Remove local pause flag
rm -f /tmp/pause-experiments

# Remove GitHub Actions pause flag (if in git repo)
if git rev-parse --git-dir > /dev/null 2>&1 && [ -f ".pause-experiments" ]; then
    rm .pause-experiments
    git add .pause-experiments
    git commit -m "Resume experiments syncing"
    git push origin master
    echo "✅ GitHub Actions will resume test-experiments sync"
fi

echo "✅ Local sync will resume test-experiments sync"
echo "🔄 Next sync will update test-experiments branch"