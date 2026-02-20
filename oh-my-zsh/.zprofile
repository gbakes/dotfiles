
# Homebrew (run ONCE)
if command -v brew >/dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# User-local binaries
export PATH="$HOME/.local/bin:$PATH"
