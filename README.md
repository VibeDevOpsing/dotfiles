# Dotfiles

This repository contains my personal dotfiles for ease of transitioning to
other devices. Feel free to check them out, copy them, or modify them.

Dotfiles managed by [stow](https://www.gnu.org/software/stow).

From the repo directory, run `stow <module>` where `module` is folder nme in this repo. Stow should then place them in the correct path.

Then, perform the following commands:
```
$ cd ~/.dotfiles
$ stow bash
$ stow vim
```
And, voila, all your config files (well, symbolic links to them) are all in the correct place.

#dotfiles #unix #macos #linux