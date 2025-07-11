#!/bin/bash

echo " Installing required tools..."
sudo apt update
sudo apt install -y sshpass rsync mailutils

echo " All tools installed:"
echo " - sshpass (SSH automation)"
echo " - rsync (file syncing)"
echo " - mailutils (for notifications)"
