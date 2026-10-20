#!/usr/bin/env zsh
# Bootstrap a new machine (macOS or Linux) from this repository.
#
# Packages and ~/.zshenv are system-specific and stay out of the repo, so this
# script installs nothing: it checks prerequisites, links the config, and
# prints the manual follow-ups.
set -e

err() { print -ru2 -- "ERROR: $*" }

cd "${0:A:h}"

if [[ $OSTYPE == darwin* && ! -x /opt/homebrew/bin/brew && ! -x /usr/local/bin/brew ]]; then
    err "Homebrew not found. Install Homebrew first."
    exit 1
fi

if ! command -v stow >/dev/null 2>&1; then
    err "GNU Stow not on PATH. Install it, then re-run."
    exit 1
fi

if [[ ! -f antidote/antidote.zsh ]]; then
    print "Initializing antidote submodule..."
    git submodule update --init
fi

print "Linking dotfiles (stow)..."
stow .

print "Done. Manual steps that stay system-specific:"
print "  1. packages: install the tools this setup assumes (zsh, tmux, nvim, zoxide, fnm, ...)"
print "  2. ~/.zshenv: PATH (incl. ~/.local/bin), plus homebrew shellenv on macOS"
print "  3. run 'p10k configure' in a new shell if the prompt needs regenerating"
print "  4. fnm: set a default Node version (e.g. 'fnm default lts')"
