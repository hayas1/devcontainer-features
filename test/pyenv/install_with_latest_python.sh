#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib
export PYENV_ROOT="$HOME/.pyenv" && eval "$(pyenv init -)"

# Definition specific tests
check "pyenv version" pyenv --version
check "python version" python --version
check "pip version" pip --version

# Report result
reportResults
