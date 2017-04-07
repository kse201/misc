#!/bin/sh

for repo in misc ansible-dotfiles ansible-base ; do
    ghq get kse201/${repo}
done

