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
check "check for sheldon" sheldon --version
check "write zshrc" diff "${HOME}/.zshrc" "${tmp}/rc" | cut -c 1 | not grep '>'

# Report result
reportResults
