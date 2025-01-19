#!/bin/bash

# Configuration
SFTP_HOST="ftp.cluster029.hosting.ovh.net"
SFTP_USER="nicolaa"
REMOTE_DIR="/home/nicolaa/" # Remote directory on OVH

# Git configuration
COMMIT_MESSAGE="Deploying site on $(date)"

# Step 1: Build the Jekyll site
echo "Building the Jekyll site..."
bundle exec jekyll build || {
  echo "Jekyll build failed!"
  exit 1
}

# Step 2: Commit and push changes to Git
echo "Committing and pushing changes to Git..."
git add -A
git commit -m "$COMMIT_MESSAGE" || { echo "Nothing to commit, skipping Git commit."; }
git push origin main || {
  echo "Git push failed!"
  exit 1
}

# Step 3: Upload the site to OVH using SCP
echo "Uploading the site to OVH hosting..."

# Use SCP to copy files
scp -r ./_site/* "$SFTP_USER@$SFTP_HOST:$REMOTE_DIR"

if [ $? -eq 0 ]; then
  echo "Deployment completed successfully!"
else
  echo "Deployment failed!"
  exit 1
fi
