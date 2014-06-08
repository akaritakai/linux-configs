# These are additions to the ~/.profile file that I have found helpful
# Do /NOT/ replace your entire ~/.profile file with this

# Sets up ssh-agent and gpg-agent with inheritance
eval $(keychain --eval --quiet)
