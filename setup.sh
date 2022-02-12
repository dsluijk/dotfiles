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

yay -Sy --noconfirm --needed zsh alacritty neovim htop wget curl ccid sway neofetch ranger npm nodejs rustup firefox fasd qt5-wayland dhcpcd rofi swayidle xorg-server-xwayland oh-my-zsh-git sl pygmentize xdg-user-dirs grim slurp wl-clipboard playerctl waybar otf-font-awesome libnotify dunst nm-applet NetworkManager sccache swaylock pipewire pipewire-pulse clipman brightnessctl zoxide fzf rust-analyzer python-pywal fd vscode-css-languageserver vscode-langservers-extracted dockerfile-language-server sqls typescript-language-server yaml-language-server

sudo systemctl enable dhcpcd
sudo systemctl start dhcpcd

if [ $SHELL != "/usr/bin/zsh" ]
then
    chsh -s /usr/bin/zsh
fi

sudo systemctl enable pcscd
sudo systemctl start pcscd

export GPG_TTY=$(tty)

gpg --import ${BASEDIR}/public.pgp

mkdir -p ~/.ssh ~/.config

ln -sf ${BASEDIR}/zsh/zshrc ~/.zshrc
ln -sf ${BASEDIR}/zsh/zprofile ~/.zprofile

ln -sf ${BASEDIR}/gitconfig ~/.gitconfig
ln -sf ${BASEDIR}/ssh/authorized_keys ~/.ssh/authorized_keys
ln -sf ${BASEDIR}/wallpapers ~/.wallpapers

ln -sf ${BASEDIR}/config/alacritty ~/.config
ln -sf ${BASEDIR}/config/nvim ~/.config
ln -sf ${BASEDIR}/config/sway ~/.config
ln -sf ${BASEDIR}/config/waybar ~/.config
ln -sf ${BASEDIR}/config/systemd ~/.config
ln -sf ${BASEDIR}/config/rofi ~/.config
ln -sf ${BASEDIR}/config/dunst ~/.config
ln -sf ${BASEDIR}/xdg.dirs ~/.config/user-dirs.dirs

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

rustup toolchain install stable
rustup default stable

mkdir -p ~/proj/{src,bin,pkg}

sudo npm install --global prettier

wal -i ~/wallpapers/mixed.jpg -a "alpha"

neofetch

echo "All done!"
echo "Please check and trust the pgp key added to the chain so it can be checked."
