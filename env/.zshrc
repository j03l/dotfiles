# Hunter's zsh config - fully self-managed

# SSH agent (systemd user service)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Local bin path
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# Path to oh-my-zsh installation
export ZSH="/usr/share/oh-my-zsh"

# Theme
ZSH_THEME="geoffgarside"

# OMZ update reminder
zstyle ':omz:update' mode reminder

# NVM lazy loading (if you use nvm)
zstyle ':omz:plugins:nvm' lazy yes

# Plugins
plugins=(git aliases history docker archlinux colorize command-not-found copybuffer copypath dotenv emoji encode64 gh man safe-paste ssh sudo tailscale themes ufw fzf)

source $ZSH/oh-my-zsh.sh
source ~/.zsh_profile

# System-installed zsh plugins (from CachyOS packages)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh

# FZF
export FZF_BASE=/usr/share/fzf

# Environment
export MANPATH="/usr/local/man:$MANPATH"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export LANG=en_AU.UTF-8

# Editor
export EDITOR='nvim'

# Fix VS Code integrated terminal (breaks local file:// URLs)
# VS Code strips desktop env vars and overrides BROWSER with its SSH helper
# Only applies when in VS Code terminal but NOT actually over SSH
if [[ "$TERM_PROGRAM" == "vscode" && -z "$SSH_CLIENT" && -z "$SSH_TTY" ]]; then
  [[ -z "$XDG_CURRENT_DESKTOP" ]] && export XDG_CURRENT_DESKTOP="KDE"
  [[ -z "$KDE_FULL_SESSION" ]] && export KDE_FULL_SESSION="true"
  export BROWSER="brave-browser"
fi

# Personal aliases
alias gcc="gcc -Wall -Wextra -Wpedantic"
alias dc="docker compose"

# Tmux project management
alias tp='tmux-project'
alias tpl='tmux list-sessions'
alias tpa='tmux attach-session -t'
alias tpk='tmux kill-session -t'
alias tpn='tmux new-session -s'
alias ts='tmux-sessionizer'  # Fuzzy find projects
alias tcht='tmux-cht'         # Cheat sheets
alias remove-orphans="sudo pacman -Qdtq | sudo pacman -Rns -"
alias governor="cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
alias performance="sudo cpupower frequency-set -g performance"
alias powersave="sudo cpupower frequency-set -g schedutil"
alias setip="~/.local/bin/set_ip.sh"
alias getip="~/.local/bin/get_ip.sh"
alias blue="hyprctl hyprsunset identity"
alias noblue="hyprctl hyprsunset temperature 2500"
alias set-colour="sudo liquidctl set ring color fixed ff2e00 && sudo liquidctl set ring color off"
alias ls="eza --icons --group-directories-first"
alias l="eza --icons --group-directories-first -1"
alias la="eza --icons --group-directories-first -a"
alias ll="eza --icons --group-directories-first -lag --git --header"
alias lt="eza --icons --group-directories-first --tree -L 2"
alias gdb="gdb --tui"
alias paru="paru --skipreview"
alias fd="find . -type d -name"
alias ff="find . -name"
alias reload!="exec zsh"

# Useful aliases from CachyOS
alias make="make -j$(nproc)"
alias ninja="ninja -j$(nproc)"
alias n="ninja"
alias jctl="journalctl -p 3 -xb"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias tb="nc termbin.com 9999"

# History config
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
export PATH="$HOME/.local/bin:$PATH"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# GOlang
export PATH=$PATH:$HOME/go/bin

# Aliases
alias c='claude'
