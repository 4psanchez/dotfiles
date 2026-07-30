# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==========================
# Oh My Zsh
# ==========================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  docker
  docker-compose
  terraform
  sudo
  extract
  history
  colored-man-pages
  zsh-autosuggestions
  fzf-tab
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ==========================
# Navegación
# ==========================

alias ls='eza --icons=auto'
alias ll='eza -lah --icons=auto'
alias la='eza -la --icons=auto'
alias lt='eza --tree --icons=auto'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias c='clear'

# ==========================
# Archivos
# ==========================

alias cat='batcat'
alias mkdir='mkdir -pv'

# ==========================
# Git
# ==========================

alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gf='git fetch'
alias gb='git branch'
alias gco='git checkout'
alias gsw='git switch'
alias gd='git diff'
alias glog='git log --oneline --graph --decorate --all'

# ==========================
# Docker
# ==========================

alias dk='docker'
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias drm='docker rm'
alias drmi='docker rmi'

# Docker Compose
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcr='docker compose restart'
alias dcl='docker compose logs -f'
alias dcp='docker compose ps'

# ==========================
# Terraform
# ==========================

alias tf='terraform'
alias tfi='terraform init'
alias tfv='terraform validate'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tff='terraform fmt'
alias tfo='terraform output'

# ==========================
# Red
# ==========================

alias ports='ss -tulpen'
alias myip='curl ifconfig.me'

# ==========================
# Completado (zstyle)
# ==========================

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no

# fzf-tab
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --level=2 --icons=auto --color=always $realpath'
zstyle ':fzf-tab:*' fzf-flags '--height=70%' '--layout=reverse' '--border'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' switch-group '<' '>'

# ==========================
# Herramientas externas
# ==========================

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

eval "$(zoxide init zsh)"

# ==========================
# Entorno
# ==========================

export PATH="$HOME/.local/bin:$PATH"

# Prompt (Powerlevel10k): ejecuta `p10k configure` o edita ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
