# Dotfiles

Atlassian has an excellent guide on dealing with dotfiles (https://www.atlassian.com/git/tutorials/dotfiles) consult this readme.

## Installing the files
1. `alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"`
2. `git clone --bare git@github.com:actuallycabbage/dotfiles.git $HOME/.dotfiles`
3. You'll probably have a bunch of files in staging now. If you don't care about losing any local changes you can yolo it with `dotfiles reset --hard HEAD`

## Some things might not be completely installed, go check out $HOME/scripts and see

## Fonts
[FantasqueSansMono](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono)
