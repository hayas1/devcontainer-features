#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib
tmp=/tmp/devcontainer-feature-gcloud-cli/test
not() {
    ! "$@"
}

# Definition specific tests
check "check for gcloud" gcloud --version | grep 'Google Cloud SDK 440.0.0'
check "check for kubectl" kubectl version --client | grep 'GitVersion:"v1.27.4"'
check "check for helm" helm version --client | grep 'Version:"v3.12.2"'
check "check for gcloud completion" diff "${HOME}/.zshrc" "${tmp}/zshrc/gcloud.zshrc" | cut -c 1 | not grep '>'
check "check for kubectl completion" diff "${HOME}/.zshrc" "${tmp}/zshrc/kubectl.zshrc" | cut -c 1 | not grep '>'
check "check for helm completion" diff "${HOME}/.zshrc" "${tmp}/zshrc/helm.zshrc" | cut -c 1 | not grep '>'

# Report result
reportResults
