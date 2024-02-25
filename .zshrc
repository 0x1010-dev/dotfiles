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
antigen bundle lukechilds/zsh-nvm
antigen bundle agkozak/zsh-z
antigen bundle greymd/docker-zsh-completion
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv

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

# Shell-GPT integration ZSH v0.2
_sgpt_zsh() {
if [[ -n "$BUFFER" ]]; then
    _sgpt_prev_cmd=$BUFFER
    BUFFER+="⌛"
    zle -I && zle redisplay
    BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd" --no-interaction)
    zle end-of-line
fi
}
zle -N _sgpt_zsh
bindkey ^l _sgpt_zsh
# Shell-GPT integration ZSH v0.2
