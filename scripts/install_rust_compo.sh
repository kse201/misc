#!/usr/bin/sh

world="
clippy
rls
rust-analysis
rust-src
rustfmt
"

echo $world|xargs rustup component add
