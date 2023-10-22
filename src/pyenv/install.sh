#! /bin/bash -e
VERSION=${VERSION:-"latest"}
WITH=${WITH:-"none"}
RC_FILE=${RC_FILE:-".zshrc"}

# for test
tmp=/tmp/devcontainer-feature-pyenv/test
mkdir -p "$tmp" && cp -r . "$tmp"

# install path
export DEBIAN_FRONTEND=noninteractive
lib="${_REMOTE_USER_HOME}/.pyenv"
bin=/usr/local/bin

# dependencies
apt-get update -y && apt-get install -y curl git build-essential zlib1g-dev libssl-dev libsqlite3-dev \
    libbz2-dev libncurses5-dev libgdbm-dev liblzma-dev tcl-dev tk-dev libreadline-dev libffi-dev &&
    apt-get clean && rm -rf /var/lib/apt/lists

# find latest
repository='https://github.com/pyenv/pyenv'
if [ "$VERSION" = "latest" ]; then
    VERSION=$(
        curl -fsL -o /dev/null -w "%{url_effective}" "${repository}/releases/latest" |
            sed -r "s,^${repository}/releases/tag/(.*)$,\1,g"
    )
fi

# install pyenv https://github.com/pyenv/pyenv#basic-github-checkout
git clone "${repository}" "$lib" --branch "${VERSION}" --depth 1
pushd "$lib" && src/configure && make -C src
popd
ln -s "$lib/bin/pyenv" "$bin/pyenv"

# install python also ?
if [ "$WITH" != "none" ]; then
    export PYENV_ROOT="${_REMOTE_USER_HOME}/.pyenv" && eval "$(pyenv init -)"
    if [ "$WITH" = "latest" ]; then
        pyenv install "$(pyenv latest 3)"
        pyenv global "$(pyenv latest 3)"
    else
        pyenv install "$WITH"
        pyenv global "$WITH"
    fi
fi

# run command
echo >>"${_REMOTE_USER_HOME}/${RC_FILE}"
cat "./rc" >>"${_REMOTE_USER_HOME}/${RC_FILE}"
