#!/bin/sh

if [ $# -lt 1 ] ; then
    echo "Usage: $0 <schedule.txt>"
    exit -1
fi

times=$(cat $1)
buff='10 minutes'
start='10 minutes'

now=$(date -d "${buff}" +%H:%M)
echo "You shoud go "$(date -d "${start}" +%H:%M)
for i in $times; do
    if ( expr A"${now}" \< A"${i}" >/dev/null) ;then
        echo "Your bus is " $i
        break
    fi
done
