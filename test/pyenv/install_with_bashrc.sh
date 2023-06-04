#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib
tmp=/tmp/devcontainer-feature-pyenv/test
export PYENV_ROOT="$HOME/.pyenv" && eval "$(pyenv init -)"

# Definition specific tests
check "pyenv version" pyenv --version
check "check for bashrc" diff "${HOME}/.bashrc" "${tmp}/rc" | cut -c 1 | not grep '>'

# Report result
reportResults
