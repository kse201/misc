#!/usr/bin/env fish

set sock_path "$HOME/.ssh/ssh-agent.sock"
set rc_path "$HOME/ssh-agentrc"

if test -e $sock_path
    echo 'ssh-agent is already running'
    source $rc_path
    exit 0
end

eval (ssh-agent -c -a "$sock_path" | tee "$rc_path")
