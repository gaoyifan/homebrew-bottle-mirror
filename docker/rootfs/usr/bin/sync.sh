#!/bin/bash
export PATH="$HOME/.linuxbrew/bin:$PATH"
LOGFILE=${LOGFILE:-"/var/log/homebrew-bottles.log"}
(
    cd ~/.linuxbrew/Library/Taps/homebrew/homebrew-core
    echo "===== SYNC STARTED AT $(date -R) ====="
    echo "> RUN git pull origin master..."
    git pull origin master
    echo ""
    echo "> RUN brew bottle-mirror..."
    brew bottle-mirror
    echo "===== SYNC FINISHED AT $(date -R) ====="
) 2>&1 | tee $LOGFILE
savelog -c 50 $LOGFILE > /dev/null
