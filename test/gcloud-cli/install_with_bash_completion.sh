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
check "check for helm" helm version
check "check for gcloud bash completion" diff "${HOME}/.bashrc" "${tmp}/bashrc/gcloud.bashrc" | cut -c 1 | not grep '>'
check "check for kubectl bash completion" diff "${HOME}/.bashrc" "${tmp}/bashrc/kubectl.bashrc" | cut -c 1 | not grep '>'
check "check for helm bash completion" diff "${HOME}/.bashrc" "${tmp}/bashrc/helm.bashrc" | cut -c 1 | not grep '>'

# Report result
reportResults
