# Linux (CachyOS/Arch) specific zsh config. Symlinked to ~/.config/zsh/os.zsh.

# oh-my-zsh installed system-wide (oh-my-zsh-git package)
export ZSH="/usr/share/oh-my-zsh"

# Platform-specific oh-my-zsh plugins (appended to the shared list)
OS_PLUGINS=(archlinux tailscale ufw)

# FZF
export FZF_BASE=/usr/share/fzf

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

# Desktop pathway (kde | gnome, from ~/.dotfiles-desktop), symlinked by deploy.
# Sourced last so it can override the aliases above (e.g. blue/noblue). Until
# deploy has linked one, fall back to the KDE fragment next to this file (the
# behaviour from before the split), resolved through the os.zsh symlink.
if [[ -r ~/.config/zsh/desktop.zsh ]]; then
  source ~/.config/zsh/desktop.zsh
else
  source "${${(%):-%x}:A:h}/desktop/kde.zsh"
fi
