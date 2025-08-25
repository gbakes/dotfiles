#!/bin/bash

# Default to gruvbox theme
THEME="${NVIM_COLORSCHEME:-gruvbox}"

case "$THEME" in
  "tokyonight")
    tmux set -g status-bg "#1a1b26"
    tmux set -g status-fg "#c0caf5"
    tmux set -g window-status-current-style "bg=#7aa2f7,fg=#1a1b26"
    tmux set -g window-status-style "bg=#414868,fg=#c0caf5"
    tmux set -g pane-border-style "fg=#414868"
    tmux set -g pane-active-border-style "fg=#7aa2f7"
    tmux set -g status-left "#[bg=#9ece6a,fg=#1a1b26] #S #[bg=#1a1b26,fg=#9ece6a] "
    tmux set -g status-right "#[bg=#1a1b26,fg=#7aa2f7]#[bg=#7aa2f7,fg=#1a1b26] #{b:pane_current_path} #[bg=#1a1b26,fg=#9ece6a]#[bg=#9ece6a,fg=#1a1b26] %H:%M "
    ;;
  "gruvbox")
    tmux set -g status-bg "#282828"
    tmux set -g status-fg "#ebdbb2"
    tmux set -g window-status-current-style "bg=#458588,fg=#282828"
    tmux set -g window-status-style "bg=#3c3836,fg=#ebdbb2"
    tmux set -g pane-border-style "fg=#3c3836"
    tmux set -g pane-active-border-style "fg=#458588"
    tmux set -g status-left "#[bg=#98971a,fg=#282828] #S #[bg=#282828,fg=#98971a] "
    tmux set -g status-right "#[bg=#282828,fg=#458588]#[bg=#458588,fg=#282828] #{b:pane_current_path} #[bg=#282828,fg=#98971a]#[bg=#98971a,fg=#282828] %H:%M "
    ;;
  "kanagawa")
    tmux set -g status-bg "#1f1f28"
    tmux set -g status-fg "#dcd7ba"
    tmux set -g window-status-current-style "bg=#7e9cd8,fg=#1f1f28"
    tmux set -g window-status-style "bg=#363646,fg=#dcd7ba"
    tmux set -g pane-border-style "fg=#363646"
    tmux set -g pane-active-border-style "fg=#7e9cd8"
    tmux set -g status-left "#[bg=#98bb6c,fg=#1f1f28] #S #[bg=#1f1f28,fg=#98bb6c] "
    tmux set -g status-right "#[bg=#1f1f28,fg=#7e9cd8]#[bg=#7e9cd8,fg=#1f1f28] #{b:pane_current_path} #[bg=#1f1f28,fg=#98bb6c]#[bg=#98bb6c,fg=#1f1f28] %H:%M "
    ;;
  *)
    # Default to catppuccin plugin
    tmux set -g @catppuccin_flavour "mocha"
    ;;
esac