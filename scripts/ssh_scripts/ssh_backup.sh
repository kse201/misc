#!/bin/sh

backup_files=".ssh"

tar cJvf "sshbackup_$(date +%Y%m%d%M%S).tar.xz" "${HOME}/${backup_files}/conf.d"
