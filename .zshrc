CONFIG=$HOME/.config/zsh
CACHE=${XDG_CACHE_HOME:-$HOME/.cache}

# must run before instant prompt, which redirects stdin/stdout/stderr
[[ -t 0 && -t 1 && -t 2 ]] && _HAS_TTY=1 || _HAS_TTY=0

# p10k instant prompt: anything needing console input must go above this
if [[ -r "$CACHE/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "$CACHE/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f $CONFIG/variables ]] || source $CONFIG/variables
[[ ! -f $HOME/.zshlocal ]] || source $HOME/.zshlocal

# history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt share_history hist_ignore_all_dups hist_ignore_space hist_verify

# omz plugins write here; unset it falls back to an unwritable /completions
ZSH_CACHE_DIR=$CACHE/omz
mkdir -p -- "$ZSH_CACHE_DIR/completions"
fpath=("$ZSH_CACHE_DIR/completions" $fpath)

# completion (full check at most once a day)
autoload -Uz compinit
_zcompdump_fresh=(${ZDOTDIR:-$HOME}/.zcompdump(N.mh-24))
if (( $#_zcompdump_fresh )); then
    compinit -C
else
    compinit
fi
unset _zcompdump_fresh

# plugins (conditional: guards are called from the antidote static file)
no-zoxide() { (( ! $+commands[zoxide] )); }
has-tty()   { (( _HAS_TTY )); }
typeset -g VI_MODE_SET_CURSOR=true
source "$HOME/.dotfiles/antidote/antidote.zsh"
antidote load "$CONFIG/zsh_plugins.txt" "$CACHE/antidote/zsh_plugins.zsh"

(( ! $+commands[zoxide] )) || eval "$(zoxide init zsh)"
(( ! $+commands[fnm] ))    || eval "$(fnm env)"

# tmux: attach/create "main" locally, "ssh" over ssh
if (( $+commands[tmux] )) && [[ -z $TMUX ]]; then
    : ${ZSH_TMUX_DEFAULT_SESSION_NAME:=main}
    [[ -n $SSH_CLIENT || -n $SSH_TTY ]] && ZSH_TMUX_DEFAULT_SESSION_NAME=ssh
    alias ta="tmux new-session -A -s $ZSH_TMUX_DEFAULT_SESSION_NAME"
fi

[[ ! -f $CONFIG/p10k ]]      || source $CONFIG/p10k
[[ ! -f $CONFIG/functions ]] || source $CONFIG/functions
[[ ! -f $CONFIG/aliases ]]   || source $CONFIG/aliases
