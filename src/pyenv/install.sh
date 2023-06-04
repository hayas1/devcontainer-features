#! /bin/bash -e
VERSION=${VERSION:-"master"}
WITH=${WITH:-"none"}
RC_FILE=${RC_FILE:-".zshrc"}

lib="${_REMOTE_USER_HOME}/.pyenv"
bin=/usr/local/bin
### https://github.com/pyenv/pyenv#basic-github-checkout
apt-get update -y && apt-get install -y git &&
    apt-get clean && rm -rf /var/lib/apt/lists
git clone https://github.com/pyenv/pyenv.git "$lib" --branch "${VERSION}" --depth 1
pushd "$lib" && src/configure && make -C src && popd
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

printf '\n' >>"${_REMOTE_USER_HOME}/.${COMPLETION}rc"
cat "./rc" >>"${_REMOTE_USER_HOME}/${RC_FILE}"
