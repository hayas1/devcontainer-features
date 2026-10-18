#! /bin/bash -e
set -e

# clone the repository into the workspace volume (used by volume/devcontainer.json)
WORKSPACE=${WORKSPACE:-"$(dirname "$(dirname "$(realpath "$0")")")"}
REMOTE_URL=${REMOTE_URL:-"$(cat "${WORKSPACE}/.devcontainer/.remote-url" 2>/dev/null || true)"}

if [ -e "${WORKSPACE}/.git" ]; then
    echo "${WORKSPACE} is already cloned, skip"
    exit 0
fi
if [ -z "${REMOTE_URL}" ]; then
    echo "remote url is not found, set origin remote of the local workspace folder or REMOTE_URL" >&2
    exit 1
fi

# volume root is owned by root
sudo chown "$(id -u):$(id -g)" "${WORKSPACE}"

# workspace is not empty because of bind mounts (.devcontainer, .vscode, ...), so clone into temporary directory
excludes=()
for entry in "${WORKSPACE}"/.[!.]* "${WORKSPACE}"/*; do
    [ -e "${entry}" ] && excludes+=(":!$(basename "${entry}")")
done
tmp="$(mktemp -d "${WORKSPACE}/.clone.XXXXXX")"
echo "clone ${REMOTE_URL} into ${WORKSPACE}..."
git_options=()
if type gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
    # authenticate https://github.com with gh (git_options are not persisted in cloned repository)
    git_options+=(-c "credential.https://github.com.helper=" -c "credential.https://github.com.helper=!gh auth git-credential")
fi
git "${git_options[@]}" clone --no-checkout "${REMOTE_URL}" "${tmp}"
mv "${tmp}/.git" "${WORKSPACE}/.git" && rmdir "${tmp}"

# checkout without overwriting bind mounted entries
if git -C "${WORKSPACE}" rev-parse -q --verify HEAD >/dev/null; then
    git -C "${WORKSPACE}" reset -q
    git -C "${WORKSPACE}" checkout -- . "${excludes[@]}"
fi
echo "done"
