# These are additions that I have made to the ~/.bashrc file
# Do /NOT/ copy this file as the whole ~/.bashrc file!

# GPG Exports
export GPGKEY=somekeyid

# Add Ruby gems to the path
function add_gems() {
  local ruby_ver=`ruby --version | awk '{print $2;}' | sed 's/^\(.*\)[A-Za-z].*$/\1/'`
  if [ -d "$HOME/.gem/ruby/$ruby_ver/bin" ]; then
    PATH="$HOME/.gem/ruby/$ruby_ver/bin:$PATH"
  fi
}
add_gems
