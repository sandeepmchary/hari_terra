#!/bin/bash
echo "Enter the commit message: "
read commit_massage
git add .
git status
git commit -m "$commit_massage"
git push origin master
