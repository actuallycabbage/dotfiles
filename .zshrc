# If you come from bash you might have to change your $PATH.

# ---- ENV
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export GOPATH=$HOME/go
export ZSH=$HOME/.oh-my-zsh
export AWS_DEFAULT_PROFILE=default
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ---- PATH
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/appimage # not sure what do do with this ione
export PATH=$PATH:$HOME/.local/share/nvim/mason/bin # nvim mason stuff

export PATH=/usr/local/bin/:$PATH
export PATH=$PATH:/opt/local/bin/

# ---- ALIAS
alias vim=nvim

alias lg=lazygit

# dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"   
alias dotfiles_lg="lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME"   
# dotfiles end

ZSH_THEME="superjarin"
# wedisagree
# tonotdo

plugins=(git)

source $ZSH/oh-my-zsh.sh

eval "$(direnv hook zsh)"

# [ -f "/home/sam/.ghcup/env" ] && source "/home/sam/.ghcup/env" # ghcup-env

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
