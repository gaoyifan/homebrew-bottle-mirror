#!/bin/bash
git clone https://github.com/Linuxbrew/brew.git ~/.linuxbrew
mkdir -p ~/.linuxbrew/Library/Taps/homebrew/homebrew-core
cd ~/.linuxbrew/Library/Taps/homebrew/homebrew-core
git init
git remote add origin git://github.com/homebrew/homebrew-core.git
export PATH="$HOME/.linuxbrew/bin:$PATH"
brew tap gaoyifan/homebrew-bottle-mirror
