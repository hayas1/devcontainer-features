#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "check for zsh theme" grep 'ZSH_THEME="powerlevel10k/powerlevel10k"' "${HOME}/.zshrc"
check "check for load .p10k.zsh" grep 'source "${HOME}/.p10k.zsh"' "${HOME}/.zshrc"

# Report result
reportResults
