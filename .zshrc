# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# ---- ENV
export GOPATH=/usr/local/go
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
alias nvim=nvim.appimage

alias lg=lazygit

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"   
alias dotfiles_lg="lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME"   

# vi stuff
alias k9s_prod='k9s --kubeconfig ~/.kube/config.vi-prod --all-namespaces'
alias kubectl_prod='kubectl --kubeconfig ~/.kube/config.vi-prod'
alias helmfile_prod='KUBECONFIG=$(readlink -f ~/.kube/config.vi-prod) helmfile'

alias k9s_staging='k9s --kubeconfig ~/.kube/config.vi-staging --all-namespaces'
alias kubectl_staging='kubectl --kubeconfig ~/.kube/config.vi-staging'
alias helmfile_staging='KUBECONFIG=$(readlink -f ~/.kube/config.vi-staging) helmfile'

alias k9s_dev='AWS_DEFAULT_PROFILE=default && k9s --kubeconfig ~/.kube/config.vi-dev --all-namespaces'
alias kubectl_dev='AWS_DEFAULT_PROFILE=default && kubectl --kubeconfig ~/.kube/config.vi-dev'
alias helmfile_dev='AWS_DEFAULT_PROFILE=default KUBECONFIG=$(readlink -f ~/.kube/config.vi-dev) helmfile'

ZSH_THEME="superjarin"
# wedisagree
# tonotdo

plugins=(git)

source $ZSH/oh-my-zsh.sh

eval "$(direnv hook zsh)"
