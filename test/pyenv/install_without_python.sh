#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib
export PYENV_ROOT="$HOME/.pyenv" && eval "$(pyenv init -)"

# Definition specific tests
check "pyenv version" pyenv --version
check "not install python" test -e "$(which python)"
check "not install pip" test -e "$(which pip)"

# Report result
reportResults
