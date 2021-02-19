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
du-dust
exa
fd
git-delta
navi
ripgrep
starship
tokei
topgrade
zoxide
"

echo "$tools" |xargs cargo install
