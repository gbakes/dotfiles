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

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

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
alias vi='nvim'
alias vim='nvim'

alias v='nvim' # default Neovim config
alias vk='NVIM_APPNAME=nvim-kickstart nvim' # Kickstart
alias va='NVIM_APPNAME=nvim-astrovim nvim' # AstroVim

vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
 
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
