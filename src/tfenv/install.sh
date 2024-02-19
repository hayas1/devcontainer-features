#! /bin/bash -e
VERSION=${VERSION:-"latest"}
WITH=${WITH:-"none"}

# install path
lib=/usr/lib/tfenv
bin=/usr/local/bin

# dependencies
apt-get update -y && apt-get install -y curl zip git &&
    apt-get clean && rm -rf /var/lib/apt/lists

# find latest
repository='https://github.com/tfutils/tfenv'
if [ "$VERSION" = "latest" ]; then
    VERSION=$(
        curl -fsL -o /dev/null -w "%{url_effective}" "${repository}/releases/latest" |
            sed -r "s,^${repository}/releases/tag/(.*)$,\1,g"
    )
fi

# install tfenv https://github.com/tfutils/tfenv#manual
git clone "${repository}" "$lib" --branch "${VERSION}" --depth 1
ln -s "$lib/bin/tfenv" "$bin/tfenv"
ln -s "$lib/bin/terraform" "$bin/terraform"

# install terraform also ?
if [ "$WITH" != "none" ]; then
    tfenv install "$WITH"
    tfenv use "$WITH"
fi
