#!/bin/sh

wget https://github.com/edihbrandon/RictyDiminished/archive/3.2.3.tar.gz
tar xzv -C ~/.local/share/fonts -f 3.2.3.tar.gz
mv ~/.local/share/fonts/RictyDiminished{-3.2.3,}/
fc-cache -vf
