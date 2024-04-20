#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "check for miniserve" miniserve --version | grep 0.27.1
check "check for cargo-readme" cargo readme --version | grep 3.3.1
check "check for cargo-tarpaulin" cargo tarpaulin --version | grep 0.28.0
check "check for tokei" tokei --version | grep 12.1.2

# Report result
reportResults
