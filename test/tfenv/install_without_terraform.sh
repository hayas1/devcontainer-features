#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

not_installed() {
    if "$1" --help >/dev/null ; then
        return 1
    else
        return 0
    fi
}

# Definition specific tests
check "tfenv version" tfenv --version
check "not install terraform" not_installed terraform

# Report result
reportResults
