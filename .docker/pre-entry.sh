#!/bin/bash

if [[ -z $DOCKER_USER ]] && [[ -z $DOCKER_UID ]]; then
    export DOCKER_UID=1000
fi
