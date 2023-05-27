#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "pyenv version" pyenv --version
check "python version" python --version | grep 'Python 3.7.16'

# Report result
reportResults
