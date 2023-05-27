#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "pyenv version" pyenv --version
check "not install python" test -e "$(which python)"

# Report result
reportResults
