#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "check for p10k version" \
    cd "${HOME}/.powerlevel10k" &&
    diff <(git describe --tags --abbrev=0) <(echo 'v1.18.0')

# Report result
reportResults
