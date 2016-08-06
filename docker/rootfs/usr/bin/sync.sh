#!/bin/bash
export PATH="$HOME/.linuxbrew/bin:$PATH"
LOGFILE=${LOGFILE:-"/var/log/homebrew-bottles.log"}
(
    cd ~/.linuxbrew/Library/Taps/homebrew/homebrew-core
    if [ ! -z $HOMEBREW_TAP ]; then
        git remote set-url origin git://github.com/Homebrew/homebrew-${HOMEBREW_TAP}.git
    fi
    echo "===== SYNC STARTED AT $(date -R) ====="
    echo "> update package info..."
    git fetch --depth=1 origin master
    git reset --hard origin/master
    echo ""
    echo "> RUN brew bottle-mirror..."
    brew bottle-mirror
    echo "===== SYNC FINISHED AT $(date -R) ====="
) 2>&1 | tee $LOGFILE
savelog -c 50 $LOGFILE > /dev/null
