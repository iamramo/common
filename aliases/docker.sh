#!/bin/bash

alias docker-compose-sync='docker-compose down && docker image prune --all --force && docker-compose up -d --build --force-recreate'
alias docker-clean='docker ps -aq | xargs --no-run-if-empty docker stop && \
                     docker ps -aq | xargs --no-run-if-empty docker rm && \
                     docker images -q | xargs --no-run-if-empty docker rmi'
