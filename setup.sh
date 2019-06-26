#!/bin/sh

if [ "$EUID" -eq 0 ]
	then echo "Please don't run as root"
	exit
fi

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK=`pwd`

sudo pacman -S --needed git

if ! pacman -Qq | grep -qw yay; then
	git clone https://aur.archlinux.org/yay.git /tmp/yay
	cd /tmp/yay
	makepkg -si
	cd ${WORK} 
fi

yay -Sy --noconfirm --needed zsh neovim htop wget ccid bspwm sxhkd polybar xorg-xrandr btops-git neofetch rofi ranger

if ! pacman -Qq | grep -qw st; then
	git clone https://git.suckless.org/st /tmp/st
	cd /tmp/st
	ls
	cd ${WORK}
fi

if [ $SHELL != "/usr/bin/zsh" ]
then
	chsh -s /usr/bin/zsh
fi

sudo systemctl enable pcscd
sudo systemctl start pcscd

export GPG_TTY=$(tty)

wget https://keybase.io/atlasdev/pgp_keys.asc -O /tmp/pgp.asc
gpg --import /tmp/pgp.asc

mkdir -p ~/.ssh

ln -sf ${BASEDIR}/gitconfig ~/.gitconfig
ln -sf ${BASEDIR}/ssh/authorized_keys ~/.ssh/authorized_keys
ln -sf ${BASEDIR}/ssh/config ~/.ssh/config
ln -sf ${BASEDIR}/xinitrc ~/.xinitrc
ln -sf ${BASEDIR}/config/bspwm ~/.config
ln -sf ${BASEDIR}/config/sxhkd ~/.config
ln -sf ${BASEDIR}/config/polybar ~/.config
ln -sf ${BASEDIR}/config/zsh/zshrc ~/.zshrc
ln -sf ${BASEDIR}/config/zsh/zlogin ~/.zlogin
ln -sf ${BASEDIR}/config/rofi ~/.config

chmod +x ~/.config/polybar/launch.sh

neofetch

echo "All done!"
echo "Please check and trust the pgp key added to the chain so it can be checked."
