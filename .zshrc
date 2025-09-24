# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::azure
zinit snippet OMZP::brew
zinit snippet OMZP::node
zinit snippet OMZP::nvm
zinit snippet OMZP::npm
zinit snippet OMZP::python
zinit snippet OMZP::terraform
zinit snippet OMZP::pyenv
zinit snippet OMZP::yarn
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
# zstyle ':completion:*:*:aws' fzf-search-display true
# zstyle ':completion:*:*:checkov' fzf-search-display true
# zstyle ':completion:*:*:az' fzf-search-display true
# zstyle ':completion:*:*:helm' fzf-search-display true
# zstyle ':completion:*:*:atmos' fzf-search-display true
# zstyle ':completion:*:*:yt-dlp' fzf-search-display true
# zstyle ':completion:*:*:gh' fzf-search-display true
zstyle ':completion:*:*:*' fzf-search-display true
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --no-quotes -lag --group-directories-first --icons -1 $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --no-quotes -lag --group-directories-first --icons -1 $realpath'

# Aliases
alias ls='eza -lag --group-directories-first --icons=auto'
alias tf="terraform"
alias k="kubectl"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Shell integrations
source <(fzf --zsh)

# disabling zoxide for now, as it doesn't play well with claude code
# eval "$(zoxide init --cmd cd zsh)"
eval "$(pyenv init --path)"

# Set fzf defaults
export FZF_DEFAULT_OPTS='-m --height 60% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g ""'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

