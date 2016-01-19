#!/bin/bash
git clone git://github.com/gaoyifan/linuxbrew.git ~/.linuxbrew
mkdir -p ~/.linuxbrew/homebrew
cd  ~/.linuxbrew/homebrew
git init
git remote add origin git://github.com/homebrew/homebrew.git
export PATH="$HOME/.linuxbrew/bin:$PATH"
brew tap gaoyifan/homebrew-bottle-mirror
