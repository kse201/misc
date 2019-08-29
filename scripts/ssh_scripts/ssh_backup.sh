#!/bin/sh

backup_files=".ssh"

tar czvf "sshbackup_$(date +%Y%m%d%M%S).tar.gz" "${HOME}/${backup_files}/conf.d" "${HOME}/${backup_files}/key.d"
