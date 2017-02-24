#!/bin/sh

# Usage:
#  # rsync.sh <src> <dest>
#
# Environment Parameters:
#     log_dir: log file destination
#     log_prefix: log filename prefix
#     rsync_src: rsync file source url
#     rsync_dest: rsync file destination

log_dir=$(dirname ${0})
log_prefix="rsync"
rsync_src=${1}
rsync_dest=${2}

RSYNC_LOG=${log_dir}/${log_prefix}-`date "+%Y%m%d-%H%M%S"`.log

echo "rsync -akv --delete ${rsync_src} ${rsync_dest}" > ${RSYNC_LOG}
rsync -akvh --delete ${rsync_src} ${rsync_dest}  >> ${RSYNC_LOG} 2>&1

echo `date "+%Y/%m/%d %H:%M:%S"`" finished, exit=0" >> ${RSYNC_LOG}

exit 0
