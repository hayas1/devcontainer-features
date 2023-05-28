#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib
export PYENV_ROOT="$HOME/.pyenv" && eval "$(pyenv init -)"

# Definition specific tests
check "pyenv version" pyenv --version
check "python version" python --version | grep 'Python 3.7.16'
check "pip version" pip --version | grep 'python 3.7'

# Report result
reportResults
