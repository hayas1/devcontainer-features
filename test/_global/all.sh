#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "check for tfenv" tfenv --version
check "check for pyenv" pyenv --version

# Report result
reportResults
