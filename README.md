# dotfiles

Personal configuration files for macOS development environment.

### Prerequisites

```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install tools
brew install git zsh tmux neovim zoxide eza fzf fd pyenv uv
```

### 1. Clone dotfiles

```bash
git clone https://github.com/gbakes/dotfiles ~/.config
cd ~/.config
```

### 2. Setup Zsh & Oh My Zsh

```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mv ~/.oh-my-zsh ~/.config/oh-my-zsh
ln -sf ~/.config/oh-my-zsh/.zshrc ~/.zshrc

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/oh-my-zsh/themes/powerlevel10k

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/oh-my-zsh/plugins/zsh-syntax-highlighting
```

### 3. Setup Tmux

```bash
# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Create symlink for tmux config
ln -sf ~/.config/tmux/.tmux.conf ~/.tmux.conf

# Install tmux plugins (after starting tmux)
# In tmux session: Press prefix + I to install plugins
```

### 4. Setup Neovim

```bash
# Create symlink for neovim config
ln -sf ~/.config/nvim ~/.config/nvim
```

### 7. Apply Configuration

```bash
# Reload zsh configuration
source ~/.zshrc

# Start tmux and install plugins
tmux
# Press prefix (Ctrl-b) + I to install tmux plugins

# Configure Powerlevel10k prompt
p10k configure
```

