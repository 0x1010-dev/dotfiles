# tmux attach alias (main session locally, ssh session over ssh)
: ${ZSH_TMUX_DEFAULT_SESSION_NAME:=main}

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    export ZSH_TMUX_DEFAULT_SESSION_NAME="ssh"
fi

if (($+commands[tmux])) && [ -z "$TMUX" ]; then
    alias ta="tmux new-session -A -s $ZSH_TMUX_DEFAULT_SESSION_NAME"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# history
HISTSIZE=50000
SAVEHIST=50000
setopt share_history hist_ignore_all_dups hist_ignore_space hist_verify

# zsh config path
CONFIG=$HOME/.config/zsh

# local configuration (not in .dotfiles)
[[ ! -f $HOME/.zshlocal ]] || source $HOME/.zshlocal

# --- plugins (Antidote, vendored in this repo as the antidote/ submodule) ---
# The bundle list lives in .config/zsh/zsh_plugins.txt (edit there to change
# plugins). `antidote load` compiles it into a cached static "source" file and
# only rebuilds that when the list changes — effectively zero cost at startup.

# guards used by the "conditional:" bundles (must exist by the time the
# static file is sourced)
no-zoxide()  { ! command -v zoxide >/dev/null 2>&1; }
# p10k/gitstatus need a real terminal; in tty-less `zsh -i -c` wrappers
# gitstatusd aborts (`setopt monitor` fails) and spams stderr before the
# prompt can be initialized
has-tty()    { [[ -t 0 && -t 1 && -t 2 ]]; }

# oh-my-zsh plugins assume OMZ core exported $ZSH_CACHE_DIR (OMZ defaults it
# to ~/.cache/omz). We only source the plugins, so define it ourselves and
# pre-create the dir tree BEFORE the bundles load — otherwise plugin
# bootstraps can try to write /completions/ (unwritable) and crash zsh.
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/omz"
mkdir -p -- "$ZSH_CACHE_DIR/completions"
fpath=("$ZSH_CACHE_DIR/completions" $fpath)

# completion system (oh-my-zsh used to run this for us) — before the plugins,
# so their compdef calls work
autoload -Uz compinit
compinit

ANTIDOTE_BUNDLES="$CONFIG/zsh_plugins.txt"
ANTIDOTE_STATIC="${XDG_CACHE_HOME:-$HOME/.cache}/antidote/zsh_plugins.zsh"
source "$HOME/.dotfiles/antidote/antidote.zsh"
antidote load "$ANTIDOTE_BUNDLES" "$ANTIDOTE_STATIC"

# vi-mode
typeset -g VI_MODE_SET_CURSOR=true

# zoxide (zsh-z loads from the plugin list only when zoxide is missing)
if (( $+commands[zoxide] )); then
    eval "$(zoxide init --cmd cd zsh)"
fi

# fnm (only if installed — kept out of .zshenv so non-interactive shells stay lightweight)
if (( $+commands[fnm] )); then
    eval "$(fnm env)"
fi

# load configuration
[[ ! -f $CONFIG/p10k ]] || source $CONFIG/p10k
[[ ! -f $CONFIG/hooks ]] || source $CONFIG/hooks
[[ ! -f $CONFIG/functions ]] || source $CONFIG/functions
[[ ! -f $CONFIG/variables ]] || source $CONFIG/variables

# load aliases last
[[ ! -f $CONFIG/aliases ]] || source $CONFIG/aliases

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/p10k.
[[ ! -f ~/.config/zsh/p10k ]] || source ~/.config/zsh/p10k
