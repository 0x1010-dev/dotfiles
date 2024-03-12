# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zsh config path
CONFIG=$HOME/.config/zsh

# load antigen
source $CONFIG/antigen

# load plugins
antigen use oh-my-zsh
antigen bundle git
antigen bundle rsync
antigen bundle vscode
antigen bundle vi-mode
antigen bundle docker
antigen bundle docker-compose
antigen bundle poetry
antigen bundle lukechilds/zsh-nvm
antigen bundle greymd/docker-zsh-completion
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv

if ! [ -f $HOME/.local/bin/zoxide ]; then
    antigen bundle agkozak/zsh-z
else
    antigen bundle zoxide
fi

# load theme
antigen theme romkatv/powerlevel10k

# apply
antigen apply

# load configuration
[[ ! -f $CONFIG/p10k ]] || source $CONFIG/p10k
[[ ! -f $CONFIG/hooks ]] || source $CONFIG/hooks
[[ ! -f $CONFIG/aliases ]] || source $CONFIG/aliases
[[ ! -f $CONFIG/functions ]] || source $CONFIG/functions
[[ ! -f $CONFIG/variables ]] || source $CONFIG/variables

# iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
