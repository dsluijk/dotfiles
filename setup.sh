#!/bin/sh

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

yay -Sy --noconfirm --needed fish neovim htop wget

if [ $SHELL != "/usr/bin/fish" ]
then
    chsh -s /usr/bin/fish
fi

wget https://keybase.io/atlasdev/pgp_keys.asc -O /tmp/pgp.asc
gpg --import /tmp/pgp.asc

ln -sf ${BASEDIR}/gitconfig ~/.gitconfig

echo "All done!"
echo "Please check and trust the pgp key added to the chain so it can be checked."
