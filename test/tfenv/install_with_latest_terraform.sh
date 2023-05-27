#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "tfenv version" tfenv --version
check "terraform version" terraform --version

# Report result
reportResults
