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

yay -Sy --noconfirm --needed zsh alacritty neovim htop wget ccid sway neofetch ranger npm nodejs rustup go go-tools firefox pulseaudio networkmanager fasd qt5-wayland

if [ $SHELL != "/usr/bin/zsh" ]
then
	chsh -s /usr/bin/zsh
fi

sudo systemctl enable pcscd
sudo systemctl start pcscd

export GPG_TTY=$(tty)

wget https://keybase.io/atlasdev/pgp_keys.asc -O /tmp/pgp.asc
gpg --import /tmp/pgp.asc

mkdir -p ~/.ssh ~/.config

ln -sf ${BASEDIR}/config/zsh/zshrc ~/.zshrc
ln -sf ${BASEDIR}/config/zsh/zprofile ~/.zprofile

ln -sf ${BASEDIR}/gitconfig ~/.gitconfig
ln -sf ${BASEDIR}/ssh/authorized_keys ~/.ssh/authorized_keys
ln -sf ${BASEDIR}/ssh/config ~/.ssh/config
ln -sf ${BASEDIR}/wallpapers ~/.wallpapers

ln -sf ${BASEDIR}/config/alacritty ~/.config
ln -sf ${BASEDIR}/config/nvim ~/.config
ln -sf ${BASEDIR}/config/sway ~/.config
ln -sf ${BASEDIR}/config/systemd ~/.config

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

rustup toolchain install stable
rustup default stable

mkdir -p ~/proj/{src,bin,pkg}
mkdir ~/.go

sudo npm install --global prettier

neofetch

echo "All done!"
echo "Please check and trust the pgp key added to the chain so it can be checked."
