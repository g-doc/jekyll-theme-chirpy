#!/bin/bash

sudo apt-get update
sudo apt-get install lftp

# Configuration

# Set variables
FTP_HOST="ftp.cluster029.hosting.ovh.net"
FTP_USER="nicolaa"
FTP_PASS=""
LOCAL_DIR="./_site" # This is where Jekyll builds the site
REMOTE_DIR="/www"

# Prompt for FTP password
echo -n "Enter FTP password: "
read -s FTP_PASS
echo

# Deploy using lftp
lftp -f "
open ftp://$FTP_USER:$FTP_PASS@$FTP_HOST
lcd $LOCAL_DIR
cd $REMOTE_DIR
mirror -R ./ ./
quit
"

# Git commit and push (optional)
git add .
git commit -m "Deploy new changes"
git push origin master
