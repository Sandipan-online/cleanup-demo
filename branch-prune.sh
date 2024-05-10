#!/bin/bash

# Set the threshold date
threshold_date=$(date -d "30 days ago" +%Y-%m-%d)

# List all branches
branches=$(git for-each-ref --format='%(refname:short) %(committerdate:short)' refs/heads/)

# Iterate over branches
while read -r branch date; do
    # Check if the branch is older than 30 days
    if [[ "$date" < "$threshold_date" ]]; then
        # Delete the branch
        git branch -D "$branch"
        echo "Deleted branch: $branch"
    fi
done <<< "$branches"
