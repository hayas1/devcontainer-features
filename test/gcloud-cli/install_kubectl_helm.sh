#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "check for gcloud" gcloud --version
check "check for kubectl" kubectl version --client
check "check for helm" helm version --client

# Report result
reportResults
