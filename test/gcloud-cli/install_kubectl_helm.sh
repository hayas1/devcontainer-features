#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib
tmp=/tmp/devcontainer-feature-gcloud-cli/test
not() {
    ! "$@"
}

# Definition specific tests
check "check for gcloud" gcloud --version
check "check for kubectl" kubectl version --client
check "check for helm" helm version --client
check "check for gcloud completion" diff "${HOME}/.zshrc" "${tmp}/zshrc-gcloud" | cut -c 1 | not grep '>'
check "check for kubectl completion" diff "${HOME}/.zshrc" "${tmp}/zshrc-kubectl" | cut -c 1 | not grep '>'
check "check for helm completion" diff "${HOME}/.zshrc" "${tmp}/zshrc-helm" | cut -c 1 | not grep '>'

# Report result
reportResults
