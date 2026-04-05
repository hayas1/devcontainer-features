#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib
export PYENV_ROOT="$HOME/.pyenv" && eval "$(pyenv init -)"

# Definition specific tests
check "pyenv version" pyenv --version
check "python version 3.7.17" python --version | grep 'Python 3.7.17'
check "pip version python 3.7" pip --version | grep 'python 3.7'

# Report result
reportResults
