#!/bin/sh
set -e

starship --version
sheldon --version

python --version
go version
cargo --version
node --version

docker --version
gcloud --version
kubectl version --client
helm version --client
