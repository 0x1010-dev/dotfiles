# .dotfiles

My command line configuration. Used on macOS and Arch Linux.

## Install

```
git clone --recurse-submodules git@github.com:0x1010-dev/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh   # or just: stow .
```

`setup.sh` checks prerequisites (Homebrew on macOS, GNU Stow everywhere), pulls
the `antidote/` submodule if missing, runs `stow .`, and prints the manual
follow-ups. Re-run `stow .` after pulling to link new files.

## Layout

- `.zshrc`, `.tmux.conf`: files that must live directly in `$HOME`
- `.config/zsh/`: aliases, functions, variables, p10k config, plugin list
- `.config/<app>/`: per-app config (nvim, kitty, foot, ghostty, helix, ...)
- `.local/bin/`: local executables (`tsh`)
- `antidote/`: vendored zsh plugin manager (submodule)

Not in the repo (system-specific): package lists, `~/.zshenv` (PATH, homebrew
shellenv), `~/.zshlocal` (per-host zsh overrides), and `~/.local/{share,state}`.

## Maintenance

```
git submodule update --remote antidote   # update antidote
antidote update                          # update zsh plugins
```
