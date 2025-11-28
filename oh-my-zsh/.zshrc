# Fix tmux compatibility issues and optimize startup
if [[ -n "$TMUX" ]] || [[ -n "$FAST_STARTUP" ]]; then
  unsetopt monitor 2>/dev/null || true
  # Disable gitstatus in tmux to prevent initialization errors
  export POWERLEVEL9K_DISABLE_GITSTATUS=true
  export GITSTATUS_ENABLE=0
  # Skip expensive initializations in tmux for faster startup
  export TMUX_FAST_MODE=1
fi

# Disable gitstatus entirely to prevent initialization errors
export POWERLEVEL9K_DISABLE_GITSTATUS=true
export GITSTATUS_ENABLE=0

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

# Add Docker Desktop for Mac (docker)
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

# Set name of the theme to load --- if set to "random", it will
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zoxide
)

source $HOME/.config/oh-my-zsh/oh-my-zsh.sh

# history setup
setopt SHARE_HISTORY
HISTFILE=$HOME/.config/oh-my-zsh/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# Lazy-load pyenv on first python/pip/pyenv command
if [[ -n "$FAST_STARTUP" ]]; then
  function python() {
    unfunction python pip pyenv 2>/dev/null
    eval "$(pyenv init -)"
    python "$@"
  }
  function pip() {
    unfunction python pip pyenv 2>/dev/null
    eval "$(pyenv init -)"
    pip "$@"
  }
  function pyenv() {
    unfunction python pip pyenv 2>/dev/null
    eval "$(pyenv init -)"
    pyenv "$@"
  }
else
  eval "$(pyenv init -)"
fi

# ---- Zoxide (better cd) ----
# Only initialize zoxide if not in fast tmux mode
if [[ -z "$TMUX_FAST_MODE" ]]; then
  eval "$(zoxide init zsh)"
fi
# Lazy-load zoxide when z command is used in tmux
if [[ -n "$TMUX_FAST_MODE" ]]; then
  z() {
    unfunction z
    eval "$(zoxide init zsh)"
    z "$@"
  }
else
  alias cd="z"
fi

# ---- Eza (better ls) -----
alias ls="eza --icons=always"
alias e="exit"

alias kbuild='bash /Users/georgebaker/Documents/2.\ Projects/zmk_sofle2/local_build/flash.sh'
alias klayers='bash /Users/georgebaker/Documents/2.\ Projects/zmk_sofle2/local_build/layout_print.sh'
alias kld='bash /Users/georgebaker/Documents/2.\ Projects/zmk_sofle2/local_build/last_deploy.sh'

alias docs='cd /Users/georgebaker/Documents'
alias work='cd /Users/georgebaker/Documents/Work'
alias notes='cd /Users/georgebaker/Documents/Notes'
alias projects='cd "/Users/georgebaker/Documents/2. Projects"'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Source custom functions
source ~/.config/oh-my-zsh/functions/swedish_word
source ~/.config/oh-my-zsh/functions/cgp
source ~/.config/oh-my-zsh/functions/gitprofile
source ~/.config/oh-my-zsh/functions/gitcheck
source ~/.config/oh-my-zsh/functions/test_gitprofile
source ~/.config/oh-my-zsh/functions/nvim_selector
source ~/.config/oh-my-zsh/functions/killport
alias vi='nvim'
alias vim='nvim'

alias v='nvim' # default Neovim config
alias vk='NVIM_APPNAME=nvim-kickstart nvim' # Kickstart
alias va='NVIM_APPNAME=nvim-astrovim nvim' # AstroVim


