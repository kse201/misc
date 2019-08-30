#!/usr/bin/env sh

compos="
clippy
rls
rust-analysis
rust-src
rustfmt
"

echo "$compos" |xargs rustup component add

tools="
cargo-edit
cargo-script
cargo-watch
starship
exa
lsd
ripgrep
"

echo "$tools" |xargs cargo install
