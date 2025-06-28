# j03l's dotfiles

A fork of [Holman's dotfiles](https://github.com/holman/dotfiles) using a topical organization pattern.

## how it works

Everything's organized by topic (git, zsh, homebrew, etc). Files are loaded based on their extension:

- `*.zsh` - Loaded into your shell environment
- `*.symlink` - Symlinked to `$HOME` without the extension
- `path.zsh` - Loaded first to setup `$PATH`
- `completion.zsh` - Loaded last for autocomplete
- `install.sh` - Run by `script/install`
- `bin/` - Added to `$PATH`

## install

```sh
git clone https://github.com/j03l/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This symlinks the appropriate files and sets up your environment. Run `bin/dot` periodically to update dependencies and macOS defaults.

## thanks

Forked from [Holman's dotfiles](https://github.com/holman/dotfiles), originally inspired by [Ryan Bates' dotfiles](http://github.com/ryanb/dotfiles).
