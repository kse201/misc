#!/usr/bin/sh

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
"

echo "$tools" |xargs cargo install
