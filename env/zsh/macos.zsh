# macOS specific zsh config. Symlinked to ~/.config/zsh/os.zsh.

# Homebrew environment (sets PATH, MANPATH, HOMEBREW_PREFIX, …)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# oh-my-zsh installed per-user via the official installer
export ZSH="$HOME/.oh-my-zsh"

# Platform-specific oh-my-zsh plugins (macos plugin adds pbcopy/ofd/etc. helpers)
OS_PLUGINS=(tailscale macos)

# FZF (Homebrew)
export FZF_BASE="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/fzf"

# Parallel build aliases (sysctl instead of Linux nproc)
alias make="make -j$(sysctl -n hw.ncpu)"
alias ninja="ninja -j$(sysctl -n hw.ncpu)"

# Runs after oh-my-zsh: Homebrew zsh plugins (syntax-highlighting must load last)
os_post_omz() {
  local share="${HOMEBREW_PREFIX:-/opt/homebrew}/share"
  [[ -r "$share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] \
    && source "$share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [[ -r "$share/zsh-history-substring-search/zsh-history-substring-search.zsh" ]] \
    && source "$share/zsh-history-substring-search/zsh-history-substring-search.zsh"
  [[ -r "$share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] \
    && source "$share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
}
