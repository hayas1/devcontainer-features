#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
echo $PATH
check "check for starship" starship --version
check "check for sheldon" sheldon --version

# Report result
reportResults
