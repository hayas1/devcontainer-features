#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "tfenv version" tfenv --version

# Report result
reportResults
