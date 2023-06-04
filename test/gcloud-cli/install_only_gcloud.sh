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
check "check for kubectl" not type kubectl >/dev/null 2>&1
check "check for helm" not type helm >/dev/null 2>&1
check "check for gcloud completion" diff "${HOME}/.zshrc" "${tmp}/zshrc/gcloud.zshrc" | cut -c 1 | not grep '>'
check "check for gcloud completion" diff "${HOME}/.zshrc" "${tmp}/zshrc/kubectl.zshrc" | cut -c 1 | grep '>'
check "check for gcloud completion" diff "${HOME}/.zshrc" "${tmp}/zshrc/helm.zshrc" | cut -c 1 | grep '>'

# Report result
reportResults
