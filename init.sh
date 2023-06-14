#!/bin/sh
set -e

REPOSITORY="$(dirname $(realpath $0))"
DEVCONTAINER_DIR=${DEVCONTAINER_DIR:-"${REPOSITORY}/.devcontainer"}

mkdir -p "${DEVCONTAINER_DIR}"
curl -fsL 'https://github.com/hayas1/devcontainer-features/raw/main/.devcontainer/devcontainer.json' \
    -o "${DEVCONTAINER_DIR}/devcontainer.json"
curl -fsL 'https://github.com/hayas1/devcontainer-features/raw/main/.devcontainer/entry.sh' \
    -o "${DEVCONTAINER_DIR}/entry.sh"
echo '*' >"${DEVCONTAINER_DIR}/.gitignore"
