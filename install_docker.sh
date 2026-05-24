#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== 1. Updating System Repositories ==="
sudo yum update -y

echo "=== 2. Installing Docker ==="
sudo yum install docker -y

echo "=== 3. Starting and Enabling Docker Service ==="
sudo systemctl start docker
sudo systemctl enable docker

echo "=== 4. Adding User to Docker Group ==="
sudo usermod -aG docker $USER

echo "=== 5. Fixing Bash Prompt Function for Sub-shells ==="
# This ensures parse_git_branch is exported properly if it's in your .bashrc
if grep -q "parse_git_branch()" ~/.bashrc && ! grep -q "export -f parse_git_branch" ~/.bashrc; then
    # Inject the export statement right after the function definition block
    sed -i '/parse_git_branch() {/,/}/ { /}/a export -f parse_git_branch\n' ~/.bashrc
    echo "Updated ~/.bashrc to export parse_git_branch safely."
fi

echo "=== 6. Reloading Environment ==="
# Reloads bashrc for the current session
source ~/.bashrc

echo "=================================================="
echo " Setup complete! To apply docker group permissions"
echo " without logging out, run: newgrp docker"
echo "=================================================="