# These are additions to the ~/.profile file that I have found helpful
# Do /NOT/ replace your entire ~/.profile file with this

# Sets up ssh-agent and gpg-agent with inheritance
# Make sure to specify after --eval what should be remembered
# a.k.a. --eval id_rsa AB1234C (where id_rsa is your SSH key and AB1234C is your GPG key)
eval $(keychain --eval --quiet)
