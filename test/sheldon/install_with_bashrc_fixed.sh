#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# test tools
tmp=/tmp/devcontainer-feature-sheldon/test
not() {
    ! "$@"
}

# Definition specific tests
check "check for sheldon" sheldon --version | grep 'sheldon 0.7.2'
check "write bashrc" diff "${HOME}/.bashrc" "${tmp}/rc" | cut -c 1 | not grep '>'

# Report result
reportResults
