#!/bin/bash
set -e

echo "1. Cleaning up any old tarball installations..."
sudo rm -rf /opt/nvim-linux-x86_64
sudo rm -f /usr/local/bin/nvim

echo "2. Downloading the latest stable Neovim tarball..."
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

echo "3. Extracting files to /opt..."
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

echo "4. Creating a clean system symlink..."
sudo ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

echo "5. Cleaning up local archive file..."
rm nvim-linux-x86_64.tar.gz

echo "6. Verifying installation:"
nvim --version

echo "7. Install lazy plugin"
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim

echo "Success! Neovim tarball installed perfectly."

