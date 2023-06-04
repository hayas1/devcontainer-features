#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

tmp=/tmp/devcontainer-feature-starship/test
not() {
    ! "$@"
}

# Definition specific tests
check "check for starship" starship --version
check "write .bashrc" diff "${HOME}/.bashrc" "${tmp}/rc" | cut -c 1 | not grep '>'

# Report result
reportResults
