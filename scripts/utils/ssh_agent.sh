#!/bin/sh

export sock_path="$HOME/.ssh/ssh-agent.sock"
export rc_path="$HOME/ssh-agentrc"

if [ -e "$sock_path" ] ; then
    echo 'ssh-agent is already running'
    # shellcheck source=/dev/null
    . "$rc_path"
    exit 0
fi

eval "$(ssh-agent -a "$sock_path" | tee "$rc_path")"
