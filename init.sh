#!/bin/bash -e

REPOSITORY="$(dirname "$(realpath "$0")")"
DEVCONTAINER_DIR=${DEVCONTAINER_DIR:-"${REPOSITORY}/.devcontainer"}
DEVCONTAINER_REF=${DEVCONTAINER_REF:-"main"} # branch, tag, or commit hash of hayas1/devcontainer-features
DEVCONTAINER_URL="https://github.com/hayas1/devcontainer-features/raw/${DEVCONTAINER_REF}/.devcontainer"

# prepare .devconotainer directory in workspace directory
if [[ ! -e "${DEVCONTAINER_DIR}" ]]; then
    mkdir -p "${DEVCONTAINER_DIR}"
    curl -fsL "${DEVCONTAINER_URL}/devcontainer.json" -o "${DEVCONTAINER_DIR}/devcontainer.json"
    curl -fsL "${DEVCONTAINER_URL}/entry.sh" -o "${DEVCONTAINER_DIR}/entry.sh"
    if grep -q 'clone.sh' "${DEVCONTAINER_DIR}/devcontainer.json"; then
        curl -fsL "${DEVCONTAINER_URL}/clone.sh" -o "${DEVCONTAINER_DIR}/clone.sh"
    fi
    echo '*' >"${DEVCONTAINER_DIR}/.gitignore"
fi

# prepare mount source in home directory (# TODO parse json-with-comment)
localWorkspaceFolder="$(dirname "${DEVCONTAINER_DIR}")"
sources="$(
    grep -E '^\s*"source=(.*)"' <"${DEVCONTAINER_DIR}/devcontainer.json" |
        sed -r 's/^\s*"source=(.*),target=(.*)"\s*,?.*$/\1/' |
        sed -r 's/localEnv://g'
)"
for s in $sources; do
    source="$(eval echo "$s")"
    if [[ "$source" =~ ^(.*)/$ ]]; then
        mkdir -p "$source"
    else
        mkdir -p "$(dirname "$source")" && touch "$source"
    fi
done
