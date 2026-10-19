# .dotfiles

A repository holding my preferred configuration for the command line + utils.

## Install

```
git clone --recurse-submodules git@github.com:0x1010-dev/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow .
```

The `--recurse-submodules` step pulls `antidote/`, the zsh plugin manager
vendored here (no separate install needed). Re-run `stow .` after pulling
to link any new files.

Alternatively run `./setup.sh` — it verifies prerequisites, handles the
submodule, links everything, and prints the manual follow-ups.

## Layout

- zsh entry points (`.zshrc`, and anything else that must live directly in `$HOME`)
- `.config/zsh/` — zsh support files (aliases, functions, variables, p10k, plugin list)
- `.config/<app>/` — per-app config (nvim, kitty, foot, ghostty, helix, ...)
- `.local/bin/` — local executables (`tsh`)
- `antidote/` — vendored zsh plugin manager (submodule)

Deliberately **not** in the repo: brew package list, `~/.zshenv`, and any
`~/.local/share` or `~/.local/state` data — all treated as system-specific.

