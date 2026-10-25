# GNOME desktop fragment. Symlinked to ~/.config/zsh/desktop.zsh by deploy
# when ~/.dotfiles-desktop is "gnome"; sourced at the end of linux.zsh.

# SSH agent: GNOME runs gcr-ssh-agent (socket-activated, enabled by
# runs/45-desktop) and exports SSH_AUTH_SOCK into the session. Only step in
# when a shell starts without a live socket (tty login, stale value).
if [[ ! -S "$SSH_AUTH_SOCK" && -S "$XDG_RUNTIME_DIR/gcr/ssh" ]]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"
fi

# Fix VS Code integrated terminal (breaks local file:// URLs). VS Code strips
# desktop env vars and overrides BROWSER with its SSH helper. Only applies when
# in the VS Code terminal but NOT actually over SSH.
if [[ "$TERM_PROGRAM" == "vscode" && -z "$SSH_CLIENT" && -z "$SSH_TTY" ]]; then
  [[ -z "$XDG_CURRENT_DESKTOP" ]] && export XDG_CURRENT_DESKTOP="GNOME"
  export BROWSER="brave-browser"
fi

# Night Light, replacing the hyprctl hyprsunset aliases. noblue forces it on
# all day (manual 00:00-23:59 schedule) at 2500K; blue turns it off.
__nl="org.gnome.settings-daemon.plugins.color"
alias blue="gsettings set $__nl night-light-enabled false"
alias noblue="gsettings set $__nl night-light-schedule-automatic false \
  && gsettings set $__nl night-light-schedule-from 0.0 \
  && gsettings set $__nl night-light-schedule-to 23.99 \
  && gsettings set $__nl night-light-temperature 'uint32 2500' \
  && gsettings set $__nl night-light-enabled true"
unset __nl
