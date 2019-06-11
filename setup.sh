#!/bin/sh

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

yay -Sy --noconfirm --needed fish neovim

chsh -s /usr/bin/fish

if [ $SHELL != "/usr/bin/fish" ]
then
    chsh -s /usr/bin/fish
fi

ln -sf ${BASEDIR}/gitconfig ~/.gitconfig
