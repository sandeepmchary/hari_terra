#!/bin/bash
echo "Enter the message"
read commit_message
echo "Enter the branch name"
read branch_name
git add .
git status
git commit -m "$commit_message"
git push origin "$branch_name"

