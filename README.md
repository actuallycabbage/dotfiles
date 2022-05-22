# Dotfiles

Atlassian has an excellent guide on dealing with dotfiles (https://www.atlassian.com/git/tutorials/dotfiles)


## Installing
1. `alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"`
2. Read https://www.atlassian.com/git/tutorials/dotfiles and update this README when figured out.

## Fonts
Trying out RobotoMono, download a pre-patched (NerdFonts) version of it [here](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/RobotoMono) (instead of cloning the repo they compile all the fonts into `.zip`s in the release tab.

`unzip RobotoMono.zip -d /Library/Fonts`

On MacOS, font installation means chucking everything into /Library/Fonts
