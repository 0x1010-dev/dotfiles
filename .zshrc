# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zsh config path
CONFIG=$HOME/.config/zsh

# local configuration (not in .dotfiles)
[[ ! -f $HOME/.zshlocal ]] || source $HOME/.zshlocal

# load antigen
source $CONFIG/antigen

# load plugins
antigen use oh-my-zsh
antigen bundle git
antigen bundle rsync
antigen bundle vi-mode
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv

if [[ -x $(command -v docker) ]]; then
    antigen bundle docker
    antigen bundle docker-compose
fi

if [[ -x $(command -v zoxide) ]]; then
    antigen bundle zoxide
else
    antigen bundle agkozak/zsh-z
fi

if [[ -x $(command -v tmux) ]]; then
    antigen bundle tmux
    # typeset -g ZSH_TMUX_AUTOCONNECT=true
    # typeset -g ZSH_TMUX_AUTOSTART=true
fi

# load theme
antigen theme romkatv/powerlevel10k

# load configuration
[[ ! -f $CONFIG/p10k ]] || source $CONFIG/p10k
[[ ! -f $CONFIG/hooks ]] || source $CONFIG/hooks
[[ ! -f $CONFIG/functions ]] || source $CONFIG/functions
[[ ! -f $CONFIG/variables ]] || source $CONFIG/variables

# apply
antigen apply

# load aliases last
[[ ! -f $CONFIG/aliases ]] || source $CONFIG/aliases

# configuration
typeset -g VI_MODE_SET_CURSOR=true

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/p10k.
[[ ! -f ~/.config/zsh/p10k ]] || source ~/.config/zsh/p10k
