# --- Oh my ZSH
ZSH_THEME="superjarin"
# wedisagree
# tonotdo
plugins=(git)
source $ZSH/oh-my-zsh.sh

# --- Env
export GOPATH=$HOME/go
export ZSH=$HOME/.oh-my-zsh
export AWS_DEFAULT_PROFILE=default
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export DISPLAY=":0"

# --- PATH
export PATH="$PATH:${KREW_ROOT:-$HOME/.krew}/bin"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/appimage # not sure what do do with this one
export PATH=$PATH:$HOME/.local/share/nvim/mason/bin # nvim mason stuff
export PATH=$PATH:/usr/local/bin/
export PATH=$PATH:/opt/local/bin/
export PATH=$PATH:"/Users/sam/Library/Application Support/org.dfinity.dfx/bin/"

# --- Alias
alias vim=nvim
alias tree=tree --gitignore
alias lg=lazygit
alias grep=grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,node_modules}
alias sl='sl -e'
alias tf='terraform'
alias curl='curl -s'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"   
alias dotfiles_lg="lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME"   

# --- Zsh plugin evals
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

# --- Cargo
export PATH=$PATH:$HOME/.cargo/bin

# --- Java
export JAVA_HOME="/opt/homebrew/opt/openjdk"
export PATH="$PATH:$JAVA_HOME/bin"

# --- Haskell
# [ -f "/home/sam/.ghcup/env" ] && source "/home/sam/.ghcup/env" # ghcup-env

# --- Python
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# --- Javascript
# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

