#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "check for starship" starship --version
check "check for sheldon" sheldon --version

check "check for tfenv" tfenv --version
check "check for pyenv" pyenv --version

check "check for gcloud" gcloud --version

# Report result
reportResults
