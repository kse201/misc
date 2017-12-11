#!/bin/sh

apk update
apk add --no-cache \
    make zlib-dev build-base python-dev jpeg-dev \
    graphviz \
    openjdk8-jre ca-certificates wget
update-ca-certificates
pip install -r /requirements.txt
pip install sphinx_fontawesome
wget -O /usr/lib/plantuml.jar 'http://downloads.sourceforge.net/project/plantuml/plantuml.jar'
apk del --purge wget
