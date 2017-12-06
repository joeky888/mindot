#! /bin/bash

export SUDO=''
if (( $EUID != 0 )); then
  export SUDO='sudo'
fi

$SUDO apt update
$SUDO apt install vim tmux git aria2 bash-completion fbterm fontconfig -y

# Install the fonts for fbterm
$SUDO aria2c https://raw.githubusercontent.com/j16180339887/CJK-font/master/UbuntuMono.ttf --dir=/ -o usr/share/fonts/truetype/UbuntuMono.ttf
$SUDO aria2c https://raw.githubusercontent.com/j16180339887/CJK-font/master/DroidSansFallback.ttf --dir=/ -o usr/share/fonts/truetype/DroidSansFallback.ttf
fc-cache -fv

# Optional : create nanorc if you like nano more than vim
find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; > ~/.nanorc

rm -rf ~/mindot
git clone --depth=1 https://github.com/j16180339887/mindot.git ~/mindot

[ -f "~/.bashrc" ]       && mv ~/.bashrc ~/.bashrc.bak
[ -f "~/.bash_profile" ] && mv ~/.bash_profile ~/.bash_profile.bak
[ -f "~/.tmux.conf" ]    && mv ~/.tmux.conf ~/.tmux.conf.bak
[ -f "~/.zshrc" ]        && mv ~/.zshrc ~/.zshrc.bak
[ -f "~/.vimrc" ]        && mv ~/.vimrc ~/.vimrc.bak
[ -f "~/.fbtermrc" ]     && mv ~/.bashrc ~/.fbtermrc.bak

ln -sf ~/mindot/.bashrc ~/.bashrc
ln -sf ~/mindot/.bashrc ~/.bash_profile
ln -sf ~/mindot/.tmux.conf ~/.tmux.conf
ln -sf ~/mindot/.bashrc ~/.zshrc
ln -sf ~/mindot/.vimrc ~/.vimrc
ln -sf ~/mindot/.fbtermrc ~/.fbtermrc

$SUDO chmod u-s $(which fbterm) # If you like to use fbterm hotkeys, use "u+s" instead
$SUDO usermod -a -G video $(whoami)

##########################################
#                                        #
# # In this order                        #
# GRUB_CMDLINE_LINUX_DEFAULT="nomodeset" #
# GRUB_CMDLINE_LINUX=""                  #
# GRUB_GFXMODE=1024x768x16               #
# GRUB_GFXPAYLOAD_LINUX=1024x768x16      #
#                                        #
##########################################

$SUDO sed -i '/GRUB_CMDLINE_LINUX/d' /etc/default/grub
$SUDO sed -i '/GRUB_GFXMODE/d' /etc/default/grub
$SUDO sed -i '/GRUB_GFXPAYLOAD_LINUX/d' /etc/default/grub

$SUDO sed -i -e "\$aGRUB_CMDLINE_LINUX_DEFAULT='nomodeset'" /etc/default/grub
$SUDO sed -i -e "\$aGRUB_CMDLINE_LINUX=''" /etc/default/grub
$SUDO sed -i -e "\$aGRUB_GFXMODE=1024x768x16" /etc/default/grub
$SUDO sed -i -e "\$aGRUB_GFXPAYLOAD_LINUX=1024x768x16" /etc/default/grub
# $SUDO echo 'GRUB_CMDLINE_LINUX=""' >> /etc/default/grub
# $SUDO echo 'GRUB_GFXMODE=1024x768x16' >> /etc/default/grub
# $SUDO echo 'GRUB_GFXPAYLOAD_LINUX=1024x768x16' >> /etc/default/grub

$SUDO update-grub && $SUDO update-grub2

echo "##############################"
echo "# The resolution is 1024x768 #"
echo "##############################"
echo ""
echo ""
echo "#############################"
echo "# Please reboot the system. #"
echo "#############################"
