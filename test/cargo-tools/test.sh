#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "check for miniserve" miniserve --version
check "check for cargo-readme" cargo readme --version
check "check for cargo-tarpaulin" cargo tarpaulin --version
check "check for tokei" tokei --version

# Report result
reportResults
