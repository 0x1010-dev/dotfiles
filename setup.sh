#!/usr/bin/env zsh
# Bootstrap a new machine from this repository.
#
# Intentional policy: brew packages and ~/.zshenv are SYSTEM-SPECIFIC and stay
# out of the repo, so this script does not install anything — it verifies
# prerequisites, links the config, and prints the manual follow-ups.
set -e

err() { print -ru2 -- "ERROR: $*" }

if [[ ! -x /opt/homebrew/bin/brew && ! -x /usr/local/bin/brew ]]; then
    err "Homebrew not found. Install Homebrew first (brew is kept system-specific on purpose)."
    exit 1
fi

if ! command -v stow >/dev/null 2>&1; then
    err "GNU Stow not on PATH — install it with your package manager of choice, then re-run."
    exit 1
fi

# make sure the vendored antidote submodule is present (clone --recurse-submodules,
# or on a pre-existing clone:)
if [[ ! -f antidote/antidote.zsh ]]; then
    print "Initializing antidote submodule..."
    git submodule update --init
fi

print "Linking dotfiles (stow)..."
stow .

print "Done. Manual steps that stay system-specific:"
print "  1. brew — install the tools your setup assumes (tmux, fnm, uv, devtunnel, ...)"
print "  2. ~/.zshenv — recreate it (homebrew shellenv / xcodes paths)"
print "  3. run 'p10k configure' in a new shell (prompt wizard, first time only)"
print "  4. fnm — set a default Node version (e.g. 'fnm default lts')"
print "      (tmux plugins install themselves on first tmux start; no action needed)"
