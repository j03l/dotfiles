# KDE Plasma desktop fragment. Symlinked to ~/.config/zsh/desktop.zsh by deploy
# when ~/.dotfiles-desktop is "kde"; sourced at the end of linux.zsh.

# SSH agent provided by a systemd user service
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Fix VS Code integrated terminal (breaks local file:// URLs). VS Code strips
# desktop env vars and overrides BROWSER with its SSH helper. Only applies when
# in the VS Code terminal but NOT actually over SSH.
if [[ "$TERM_PROGRAM" == "vscode" && -z "$SSH_CLIENT" && -z "$SSH_TTY" ]]; then
  [[ -z "$XDG_CURRENT_DESKTOP" ]] && export XDG_CURRENT_DESKTOP="KDE"
  [[ -z "$KDE_FULL_SESSION" ]] && export KDE_FULL_SESSION="true"
  export BROWSER="brave-browser"
fi
