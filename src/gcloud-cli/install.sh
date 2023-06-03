#! /bin/bash -e
VERSION=${VERSION:-"latest"}
WITH_KUBECTL=${WITH_KUBECTL:-"none"}
WITH_HELM=${WITH_HELM:-"none"}

# for test
tmp=/tmp/devcontainer-feature-gcloud-cli/test
mkdir -p "$tmp" && cp -r . "$tmp"

# install required tools
apt-get update -y && apt-get install -y curl gnupg &&
    apt-get clean && rm -rf /var/lib/apt/lists

# install gcloud and kubectl https://cloud.google.com/sdk/docs/install?hl=ja#deb
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" |
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg |
    apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
if [ "$VERSION" = "latest" ]; then
    apt-get update -y && apt-get install -y google-cloud-sdk
else
    apt-get update -y && apt-get install -y google-cloud-sdk="${VERSION}"
fi
cat ./gcloud.zshrc >>"${_REMOTE_USER_HOME}/.zshrc"

if [ "$WITH_KUBECTL" != "none" ]; then
    if [ "$WITH_KUBECTL" = "latest" ]; then
        apt-get install -y kubectl
    else
        apt-get install -y kubectl="${WITH_KUBECTL}"
    fi
    cat ./kubectl.zshrc >>"${_REMOTE_USER_HOME}/.zshrc"
fi

if [ "$WITH_HELM" != "none" ]; then
    # install helm https://helm.sh/docs/intro/install/#from-apt-debianubuntu
    curl https://baltocdn.com/helm/signing.asc |
        gpg --dearmor | tee /usr/share/keyrings/helm.gpg >/dev/null
    apt-get install apt-transport-https --yes
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" |
        tee /etc/apt/sources.list.d/helm-stable-debian.list
    if [ "$WITH_KUBECTL" = "latest" ]; then
        apt-get update -y && apt-get -y install helm
    else
        apt-get update -y && apt-get -y install helm="${WITH_HELM}"
    fi
    cat ./helm.zshrc >>"${_REMOTE_USER_HOME}/.zshrc"
fi
