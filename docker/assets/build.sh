#!/bin/bash
git clone git://github.com/gaoyifan/linuxbrew.git ~/.linuxbrew
mkdir -p ~/.linuxbrew/homebrew-core
cd  ~/.linuxbrew/homebrew-core
git init
git remote add origin git://github.com/homebrew/homebrew-core.git
export PATH="$HOME/.linuxbrew/bin:$PATH"
brew tap gaoyifan/homebrew-bottle-mirror
