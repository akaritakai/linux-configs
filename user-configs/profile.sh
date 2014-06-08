# These are additions to the ~/.profile file that I have found helpful
# Do /NOT/ replace your entire ~/.profile file with this

# Check to see if SSH agent is already running
agent_pid="$(ps -ef | grep "ssh-agent" | grep -v "grep" | awk '{print($2)}')"

# Start SSH agent if not running
if [[ -z "$agent_pid" ]]; then
    eval "$(ssh-agent)"
    ssh-add
else # SSH agent is already running
    agent_ppid="$(($agent_pid - 1))"
    agent_sock="$(find /tmp -path "*ssh*" -type s -iname "agent.$agent_ppid")"
    export SSH_AGENT_PID="$agent_pid"
    export SSH_AUTH_SOCK="$agent_sock"
fi

# Add Ruby Gems to the path
for ruby_ver in $HOME/.gem/ruby/*; do
  if [ -d "$ruby_ver/bin" ]; then
    PATH="$ruby_ver/bin:$PATH"
  fi
done
