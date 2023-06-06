#!/bin/sh -e
RC_FILE=${RC_FILE:-".zshrc"}

# for test
tmp=/tmp/devcontainer-feature-starship/test
mkdir -p "$tmp" && cp -r . "$tmp"

# dependencies
apt-get update -y && apt-get install -y curl &&
    apt-get clean && rm -rf /var/lib/apt/lists

# https://starship.rs/#quick-install
curl -fsL https://starship.rs/install.sh | sh -s -- -y

# multi bytes
apt-get update -y && apt-get upgrade -y && apt-get install -y locales &&
    apt-get clean && rm -rf /var/lib/apt/lists
localedef -f UTF-8 -i en_US en_US.UTF-8

printf '\n' >>"${_REMOTE_USER_HOME}/${RC_FILE}"
cat "./rc" >>"${_REMOTE_USER_HOME}/${RC_FILE}"
