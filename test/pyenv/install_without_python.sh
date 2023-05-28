#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib
export PYENV_ROOT="$HOME/.pyenv" && eval "$(pyenv init -)"

not_exist() {
    if type "$1" >/dev/null ; then
        return 1
    else
        return 0
    fi
}

# Definition specific tests
check "pyenv version" pyenv --version
check "not install python" not_exist python
check "not install pip" not_exist pip

# Report result
reportResults
