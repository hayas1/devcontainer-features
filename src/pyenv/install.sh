#! /bin/bash -e
VERSION=${VERSION:-"master"}
WITH=${WITH:-"none"}
RC_FILE=${RC_FILE:-".zshrc"}

# for test
tmp=/tmp/devcontainer-feature-pyenv/test
mkdir -p "$tmp" && cp -r . "$tmp"

lib="${_REMOTE_USER_HOME}/.pyenv"
bin=/usr/local/bin
# dependencies
apt-get update -y && apt-get install -y git build-essential zlib1g-dev libssl-dev libsqlite3-dev \
    libbz2-dev libncurses5-dev libgdbm-dev liblzma-dev tcl-dev tk-dev libreadline-dev &&
    apt-get clean && rm -rf /var/lib/apt/lists
# https://github.com/pyenv/pyenv#basic-github-checkout
git clone https://github.com/pyenv/pyenv.git "$lib" --branch "${VERSION}" --depth 1
pushd "$lib" && src/configure && make -C src
popd
ln -s "$lib/bin/pyenv" "$bin/pyenv"

if [ "$WITH" != "none" ]; then
    if [ "$WITH" = "latest" ]; then
        WITH="3:latest"
        GLOBAL=3
    else
        GLOBAL=$WITH
    fi
    export PYENV_ROOT="${_REMOTE_USER_HOME}/.pyenv" && eval "$(pyenv init -)"
    pyenv install "$WITH"
    pyenv global "$GLOBAL"
fi

printf '\n' >>"${_REMOTE_USER_HOME}/${RC_FILE}"
cat "./rc" >>"${_REMOTE_USER_HOME}/${RC_FILE}"
