#! /bin/bash -e
VERSION=${VERSION:-"latest"}
WITH_KUBECTL=${WITH_KUBECTL:-"none"}
WITH_HELM=${WITH_HELM:-"none"}
COMPLETION=${COMPLETION:-"zsh"}

# install a pinned apt package, listing what the repository actually has when the pin does not exist
apt_install_version() {
    local package="$1" version="$2"
    if ! apt-get install -y "${package}=${version}"; then
        echo "gcloud-cli: version '${version}' of '${package}' is not available, available versions are:" >&2
        apt-cache madison "${package}" >&2
        return 1
    fi
}

# for test
tmp=/tmp/devcontainer-feature-gcloud-cli/test
mkdir -p "$tmp" && cp -r . "$tmp"

# install required tools
apt-get update -y && apt-get install -y curl gnupg
if [ "$COMPLETION" = "bash" ]; then
    apt-get install -y bash-completion
fi
apt-get clean && rm -rf /var/lib/apt/lists/*
printf '\n' >>"${_REMOTE_USER_HOME}/.${COMPLETION}rc"

# install gcloud https://cloud.google.com/sdk/docs/install#deb
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg |
    gpg --dearmor --yes -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" |
    tee /etc/apt/sources.list.d/google-cloud-sdk.list
if [ "$VERSION" = "latest" ]; then
    apt-get update -y && apt-get install -y google-cloud-cli
else
    apt-get update -y && apt_install_version google-cloud-cli "${VERSION}"
fi
cat "./${COMPLETION}rc/gcloud.${COMPLETION}rc" >>"${_REMOTE_USER_HOME}/.${COMPLETION}rc"

# install kubectl https://cloud.google.com/sdk/docs/install#deb-additional
if [ "$WITH_KUBECTL" != "none" ]; then
    if [ "$WITH_KUBECTL" = "latest" ]; then
        apt-get install -y kubectl
    else
        apt_install_version kubectl "${WITH_KUBECTL}"
    fi
    cat "./${COMPLETION}rc/kubectl.${COMPLETION}rc" >>"${_REMOTE_USER_HOME}/.${COMPLETION}rc"
fi

# install helm https://github.com/helm/helm/issues/31417
if [ "$WITH_HELM" != "none" ]; then
    if [ "$WITH_HELM" = "latest" ]; then
        curl -fsSL https://github.com/helm/helm/raw/main/scripts/get-helm-4 | bash
    else
        curl -fsSL https://github.com/helm/helm/raw/main/scripts/get-helm-"${WITH_HELM}" | bash
    fi
    cat "./${COMPLETION}rc/helm.${COMPLETION}rc" >>"${_REMOTE_USER_HOME}/.${COMPLETION}rc"
fi
