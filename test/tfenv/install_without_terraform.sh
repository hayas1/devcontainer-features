#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "tfenv version" tfenv --version
check "not install terraform" ! type terraform

# Report result
reportResults
