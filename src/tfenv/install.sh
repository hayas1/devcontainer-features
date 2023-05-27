#! /bin/bash -e
VERSION=${VERSION:-"master"}
WITH=${WITH:-"none"}

lib=/usr/lib/tfenv
bin=/usr/bin
# https://github.com/tfutils/tfenv#manual
apt-get update -y && apt-get install -y zip git &&
    apt-get clean && rm -rf /var/lib/apt/lists
git clone https://github.com/tfutils/tfenv.git "$lib" -b "${VERSION}" --depth 1
ln -s "$lib/bin/tfenv" "$bin/tfenv"
ln -s "$lib/bin/terraform" "$bin/terraform"

if [ "$WITH" != "none" ]; then
    tfenv install "$WITH"
    tfenv use "$WITH"
fi
