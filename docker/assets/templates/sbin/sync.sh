#!/bin/bash

LOGFILE=${LOGFILE:-"/var/log/homebrew-bottles/homebrew-bottles.log"}
(
    cd ~/.linuxbrew/homebrew-core
    echo "===== SYNC STARTED AT $(date -R) ====="
    echo "> RUN git pull origin master..."
    git pull origin master
    echo ""
    echo "> RUN brew bottle-mirror..."
    brew bottle-mirror
    echo "===== SYNC FINISHED AT $(date -R) ====="
) > $LOGFILE 2>&1
savelog -c 50 $LOGFILE > /dev/null
