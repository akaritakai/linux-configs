# These are additions to the ~/.profile file that I have found helpful
# Do /NOT/ replace your entire ~/.profile file with this

# Sets up ssh-agent and gpg-agent with inheritance
eval $(keychain --eval --quiet)

# Add Ruby Gems to the path
for ruby_ver in $HOME/.gem/ruby/*; do
  if [ -d "$ruby_ver/bin" ]; then
    PATH="$ruby_ver/bin:$PATH"
  fi
done
