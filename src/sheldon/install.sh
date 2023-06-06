#!/bin/sh -e
VERSION=${VERSION:-"latest"}
RC_FILE=${RC_FILE:-".zshrc"}

# for test
tmp=/tmp/devcontainer-feature-sheldon/test
mkdir -p "$tmp" && cp -r . "$tmp"

# dependencies
apt-get update -y && apt-get install -y curl &&
    apt-get clean && rm -rf /var/lib/apt/lists

# https://sheldon.cli.rs/Installation.html#pre-built-binaries
if [ "$VERSION" = "latest" ]; then
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh |
        bash -s -- --repo rossmacarthur/sheldon --to /usr/local/bin
else
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh |
        bash -s -- --repo rossmacarthur/sheldon --to /usr/local/bin --tag "${VERSION}"
fi

printf '\n' >>"${_REMOTE_USER_HOME}/${RC_FILE}"
cat "./rc" >>"${_REMOTE_USER_HOME}/${RC_FILE}"
