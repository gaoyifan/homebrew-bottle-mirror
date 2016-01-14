#!/bin/bash
git clone git://github.com/gaoyifan/linuxbrew.git ~/.linuxbrew
git clone git://github.com/homebrew/homebrew.git ~/.linuxbrew/homebrew
export PATH="$HOME/.linuxbrew/bin:$PATH"
brew tap gaoyifan/homebrew-bottle-mirror
