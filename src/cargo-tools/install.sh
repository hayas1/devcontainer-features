#! /bin/bash -e

cargo-install() {
    TOOL=$1
    VERSION=${2:-"latest"}
    if [ "$VERSION" != "none" ]; then
        if [ "$VERSION" = "latest" ]; then
            cargo install "$TOOL"
        else
            cargo install "$TOOL"@"$VERSION"
        fi
    fi
}

cargo-install miniserve "${MINISERVE:-'latest'}"
cargo-install cargo-readme "${CARGO_README:-'latest'}"
cargo-install cargo-tarpaulin "${CARGO_TARPAULIN:-'latest'}"
cargo-install tokei "${TOKEI:-'latest'}"
