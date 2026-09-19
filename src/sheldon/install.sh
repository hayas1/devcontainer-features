#!/bin/sh -e
VERSION=${VERSION:-"latest"}
RC_FILE=${RC_FILE:-".zshrc"}

# for test
tmp=/tmp/devcontainer-feature-sheldon/test
mkdir -p "$tmp" && cp -r . "$tmp"

# dependencies
apt-get update -y && apt-get install -y curl ca-certificates tar &&
    apt-get clean && rm -rf /var/lib/apt/lists/*

# find latest
# resolve the tag from the releases/latest redirect instead of api.github.com,
# which allows only 60 unauthenticated requests per hour per IP and answers 403
# for every request after that
repository='https://github.com/rossmacarthur/sheldon'
if [ "$VERSION" = "latest" ]; then
    VERSION=$(
        curl -fsL --retry 3 -o /dev/null -w "%{url_effective}" "${repository}/releases/latest" |
            sed -r "s,^${repository}/releases/tag/(.*)$,\1,g"
    )
    case "$VERSION" in
    '' | *'/'*)
        echo "failed to resolve the latest release from ${repository}/releases/latest"
        exit 1
        ;;
    esac
fi

# install https://sheldon.cli.rs/Installation.html#pre-built-binaries
# linux binaries are published for musl targets only, statically linked so that
# one artifact runs on both the debian and ubuntu bases
archive="sheldon-${VERSION}-$(uname -m)-unknown-linux-musl.tar.gz"
extract=$(mktemp -d)
curl --proto '=https' -fLsS --retry 3 "${repository}/releases/download/${VERSION}/${archive}" |
    tar xz -C "$extract"
install -m 0755 "${extract}/sheldon" /usr/local/bin/sheldon
rm -rf "$extract"

printf '\n' >>"${_REMOTE_USER_HOME}/${RC_FILE}"
cat "./rc" >>"${_REMOTE_USER_HOME}/${RC_FILE}"
