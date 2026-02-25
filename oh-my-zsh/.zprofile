
# Homebrew (run ONCE)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# User-local binaries
export PATH="$HOME/.local/bin:$PATH"
