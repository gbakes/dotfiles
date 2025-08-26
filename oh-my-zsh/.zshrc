# Initialize Homebrew PATH (must be before instant prompt)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Github profiles 
ssh-add ~/.ssh/github_personal 2>/dev/null
ssh-add ~/.ssh/github_work 2>/dev/null

# Source custom zsh functions
source ~/.config/oh-my-zsh/functions/gitprofile
source ~/.config/oh-my-zsh/functions/nvim_selector
source ~/.config/oh-my-zsh/functions/swedish_word

export ZSH="$HOME/.config/oh-my-zsh"

export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

source $HOME/.config/oh-my-zsh/oh-my-zsh.sh

# history setup
setopt SHARE_HISTORY
HISTFILE=$HOME/.config/oh-my-zsh/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST

# Enable vi mode
bindkey -v

# easyexit
alias "e"=exit

# ---- Zoxide (better cd) ----
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

alias cd="z"
alias ls="eza --icons=always"
alias ll="eza -lah --icons=always"
alias kbuild='bash /Users/georgebaker/Documents/2.\ Projects/zmk_sofle2/local_build/flash.sh'
alias klayers='bash /Users/georgebaker/Documents/2.\ Projects/zmk_sofle2/local_build/layout_print.sh'
alias kld='bash /Users/georgebaker/Documents/2.\ Projects/zmk_sofle2/local_build/last_deploy.sh'
alias docs='cd /Users/georgebaker/Documents'
alias work='cd /Users/georgebaker/Documents/Work'
alias notes='cd /Users/georgebaker/Documents/Notes'
alias projects="cd /Users/georgebaker/Library/Mobile Documents/com~apple~CloudDocs/Documents/2. Projects"
alias e="exit"
alias vi='nvim'
alias vim='nvim'
alias v='nvim' # default Neovim config
alias vk='NVIM_APPNAME=nvim-kickstart nvim' # Kickstart
alias va='NVIM_APPNAME=nvim-astrovim nvim' # AstroVim

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ssh-add ~/.ssh/github_personal 2>/dev/null
ssh-add ~/.ssh/github_work 2>/dev/null
export PATH="$HOME/.local/bin:$PATH"
