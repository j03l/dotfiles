# Linux (CachyOS/Arch) specific zsh config. Symlinked to ~/.config/zsh/os.zsh.

# oh-my-zsh installed system-wide (oh-my-zsh-git package)
export ZSH="/usr/share/oh-my-zsh"

# Platform-specific oh-my-zsh plugins (appended to the shared list)
OS_PLUGINS=(archlinux tailscale ufw)

# SSH agent provided by a systemd user service
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# FZF
export FZF_BASE=/usr/share/fzf

# Fix VS Code integrated terminal (breaks local file:// URLs). VS Code strips
# desktop env vars and overrides BROWSER with its SSH helper. Only applies when
# in the VS Code terminal but NOT actually over SSH.
if [[ "$TERM_PROGRAM" == "vscode" && -z "$SSH_CLIENT" && -z "$SSH_TTY" ]]; then
  [[ -z "$XDG_CURRENT_DESKTOP" ]] && export XDG_CURRENT_DESKTOP="KDE"
  [[ -z "$KDE_FULL_SESSION" ]] && export KDE_FULL_SESSION="true"
  export BROWSER="brave-browser"
fi

# Arch / desktop aliases
alias remove-orphans="sudo pacman -Qdtq | sudo pacman -Rns -"
alias governor="cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
alias performance="sudo cpupower frequency-set -g performance"
alias powersave="sudo cpupower frequency-set -g schedutil"
alias blue="hyprctl hyprsunset identity"
alias noblue="hyprctl hyprsunset temperature 2500"
alias set-colour="sudo liquidctl set ring color fixed ff2e00 && sudo liquidctl set ring color off"
alias setip="~/.local/bin/set_ip.sh"
alias getip="~/.local/bin/get_ip.sh"
alias gdb="gdb --tui"
alias paru="paru --skipreview"
alias open="xdg-open"
alias zed="zeditor"
alias make="make -j$(nproc)"
alias ninja="ninja -j$(nproc)"
alias jctl="journalctl -p 3 -xb"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Runs after oh-my-zsh: system zsh plugins (syntax-highlighting must load last)
os_post_omz() {
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  source /usr/share/doc/pkgfile/command-not-found.zsh
}
