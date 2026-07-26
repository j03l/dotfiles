# Hunter's zsh config — shared across Linux (CachyOS/Arch) + macOS.
# OS-specific bits live in ~/.config/zsh/os.zsh, symlinked per-platform by deploy
# (env/zsh/linux.zsh or env/zsh/macos.zsh). That fragment sets $ZSH (the oh-my-zsh
# path differs per OS), appends $OS_PLUGINS, and defines os_post_omz() for things
# that must load after oh-my-zsh (plugin sourcing, etc.).

# Local bin + language paths. The macOS fragment additionally prepends Homebrew
# via `brew shellenv`.
export PATH="$HOME/.local/bin:/usr/local/bin:$HOME/go/bin:$PATH"

# Base oh-my-zsh plugin set (OS fragment appends platform-specific plugins)
plugins=(git aliases history docker colorize command-not-found copybuffer copypath emoji encode64 gh man safe-paste ssh sudo themes fzf)

# Theme + OMZ behaviour
ZSH_THEME="geoffgarside"
zstyle ':omz:update' mode reminder
zstyle ':omz:plugins:nvm' lazy yes

# Platform layer: sets $ZSH, $OS_PLUGINS, defines os_post_omz, exports brew env…
[[ -r ~/.config/zsh/os.zsh ]] && source ~/.config/zsh/os.zsh
plugins+=(${OS_PLUGINS[@]})

source $ZSH/oh-my-zsh.sh
source ~/.zsh_profile

# Platform bits that must run after oh-my-zsh (e.g. syntax highlighting loads last)
typeset -f os_post_omz >/dev/null && os_post_omz

# Tailscale hostname injected before username in prompt (computed once at startup;
# self-guards, so it's a no-op where the tailscale CLI isn't on PATH).
__ts_host=$(tailscale status --json --self=true --peers=false 2>/dev/null | jq -r 'select(.BackendState=="Running") | .Self.DNSName // empty' 2>/dev/null | cut -d. -f1)
if [[ -n "$__ts_host" ]]; then
  __ts_repl="%F{cyan}${__ts_host}%f:%n"
  PROMPT=${PROMPT//'%n'/$__ts_repl}
  unset __ts_repl
fi
unset __ts_host

# Environment
export MANPATH="/usr/local/man:$MANPATH"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export LANG=en_AU.UTF-8
export EDITOR='nvim'

# Personal aliases (cross-platform)
alias gcc="gcc -Wall -Wextra -Wpedantic"
alias dc="docker compose"
alias n="ninja"
alias tb="nc termbin.com 9999"

# Tmux project management
alias tp='tmux-project'
alias tpl='tmux list-sessions'
alias tpa='tmux attach-session -t'
alias tpk='tmux kill-session -t'
alias tpn='tmux new-session -s'
alias ts='tmux-sessionizer'  # Fuzzy find projects
alias tcht='tmux-cht'         # Cheat sheets

# eza
alias ls="eza --icons --group-directories-first"
alias l="eza --icons --group-directories-first -1"
alias la="eza --icons --group-directories-first -a"
alias ll="eza --icons --group-directories-first -lag --header"
alias llg="eza --icons --group-directories-first -lag --git --header"
alias lt="eza --icons --group-directories-first --tree -L 2"

alias fd="find . -type d -name"
alias ff="find . -name"
alias reload!="exec zsh"
alias c='claude'

# uv (Python package manager) aliases
alias ui='uv init'
alias un='uv init --name'
alias us='uv sync'
alias ua='uv add'
alias ur='uv remove'
alias ul='uv lock'
alias venv='uv venv'
alias uva='source .venv/bin/activate'
alias uu='uv run'
alias up='uv run python'
alias upi='uv run python -i'
alias ut='uv tool'
alias uti='uv tool install'
alias utr='uv tool run'
alias upy='uv python'
alias upyl='uv python list'
alias upyi='uv python install'
alias utest='uv run pytest'
alias ufmt='uv run ruff format'
alias ulint='uv run ruff check'
alias userver='uv run python -m http.server'

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

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Rust / cargo (rustup installs to ~/.cargo; no-op if absent, e.g. system cargo on Arch)
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# direnv — replaced the omz `dotenv` plugin (2026-07-26): that plugin only
# sources .env on cd, never unsets on leave, so project secrets leaked into
# every later shell/project for the rest of the session (e.g. datadog's
# GITHUB_TOKEN clobbering `gh` auth elsewhere). direnv diffs and restores
# the environment on cd, so nothing outlives the directory it came from.
eval "$(direnv hook zsh)"

# mise — per-directory runtime versions (e.g. Node from a project's mise.toml).
# Kept last so its shims win over system tools and the PATH edits above.
eval "$(mise activate zsh)"
