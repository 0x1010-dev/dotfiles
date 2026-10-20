_zcfg=$HOME/.config/zsh
_zcache=${XDG_CACHE_HOME:-$HOME/.cache}

# must run before instant prompt, which redirects stdin/stdout/stderr
[[ -t 0 && -t 1 && -t 2 ]] && _HAS_TTY=1 || _HAS_TTY=0

# p10k instant prompt: anything needing console input must go above this
if [[ -r "$_zcache/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "$_zcache/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=nvim
[[ ! -f $HOME/.zshlocal ]] || source $HOME/.zshlocal

# history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt share_history extended_history hist_ignore_all_dups hist_ignore_space \
    hist_reduce_blanks hist_verify

# omz plugins write here; unset it falls back to an unwritable /completions
ZSH_CACHE_DIR=$_zcache/omz
mkdir -p -- "$ZSH_CACHE_DIR/completions"
fpath=("$ZSH_CACHE_DIR/completions" $fpath)

# plugins (conditional: guards are called from the antidote static file)
no-zoxide() { (( ! $+commands[zoxide] )); }
has-tty()   { (( _HAS_TTY )); }
typeset -g VI_MODE_SET_CURSOR=true
# queue compdef calls until compinit, so plugin fpath entries are seen by it
typeset -ga _compdef_queue
compdef() { _compdef_queue+=("${(j: :)${(q)@}}") }
source "$HOME/.dotfiles/antidote/antidote.zsh"
antidote load "$_zcfg/zsh_plugins.txt" "$_zcache/antidote/zsh_plugins.zsh"

# completion: full check daily or after plugin list changes, cached dump otherwise
autoload -Uz compinit
_zdump=${ZDOTDIR:-$HOME}/.zcompdump
_zfresh=($_zdump(N.mh-24))
if (( $#_zfresh )) && [[ $_zdump -nt $_zcache/antidote/zsh_plugins.zsh ]]; then
    compinit -C -d $_zdump
else
    compinit -d $_zdump && touch $_zdump
fi
for _c in $_compdef_queue; do eval "compdef $_c"; done
unset _compdef_queue _zdump _zfresh _c

(( ! $+commands[zoxide] )) || eval "$(zoxide init zsh)"
(( ! $+commands[fnm] ))    || eval "$(fnm env)"

# tmux: attach/create "main" locally, "ssh" over ssh
if (( $+commands[tmux] )) && [[ -z $TMUX ]]; then
    : ${ZSH_TMUX_DEFAULT_SESSION_NAME:=main}
    [[ -n $SSH_CLIENT || -n $SSH_TTY ]] && ZSH_TMUX_DEFAULT_SESSION_NAME=ssh
    alias ta="tmux new-session -A -s $ZSH_TMUX_DEFAULT_SESSION_NAME"
fi

[[ ! -f $_zcfg/p10k ]]      || source $_zcfg/p10k
[[ ! -f $_zcfg/functions ]] || source $_zcfg/functions
[[ ! -f $_zcfg/aliases ]]   || source $_zcfg/aliases
unset _zcfg _zcache
