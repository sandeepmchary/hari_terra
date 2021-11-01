#!/bin/bash
echo "Enter the branch name"
read branch_name
git pull origin "$branch_name"
