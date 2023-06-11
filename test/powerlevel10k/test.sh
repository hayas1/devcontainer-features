#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "check for p10k default installation" grep 'powerlevel10k.zsh-theme' "${HOME}/.zshrc"

# Report result
reportResults
