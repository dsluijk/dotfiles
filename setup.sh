#!/bin/sh

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

yay -Sy --noconfirm --needed fish neovim htop wget ccid bspwm sxhkd urxvt polybar xorg-xrandr

if [ $SHELL != "/usr/bin/fish" ]
then
    chsh -s /usr/bin/fish
fi

sudo systemctl enable pcscd
sudo systemctl start pcscd

export GPG_TTY=$(tty)

wget https://keybase.io/atlasdev/pgp_keys.asc -O /tmp/pgp.asc
gpg --import /tmp/pgp.asc

mkdir -p ~/.ssh

ln -sf ${BASEDIR}/gitconfig ~/.gitconfig
ln -sf ${BASEDIR}/ssh/authorized_keys ~/.ssh/authorized_keys
ln -sf ${BASEDIR}/xinitrc ~/.xinitrc
ln -sf ${BASEDIR}/config/bspwm ~/.config
ln -sf ${BASEDIR}/config/sxhkd ~/.config
ln -sf ${BASEDIR}/config/polybar ~/.config
ln -sf ${BASEDIR}/config/fish ~/.config

set -U fish_greeting
chmod +x ~/.config/polybar/launch.sh

echo "All done!"
echo "Please check and trust the pgp key added to the chain so it can be checked."
