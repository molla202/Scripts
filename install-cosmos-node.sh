#!/bin/bash
clear
# matrix (optional)
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/matrix.sh | bash
# Logo
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/socrates.sh | bash
# install binary function
install_binary() {
exec > /dev/null 2>&1
git clone ...
cd ...
git checkout ...
make install
exec > /dev/tty 2>&1
}
# set variables
BinaryName = "noded"
NodeName = "project"
binaryversion = "v.1.1"
ChainID = "chainid.l"
CustomPort = "111"
echo -e "\e[0;34m$NodeName Kurulumu Başlatılıyor\033[0m"
sleep 3
# get moniker
echo -e '\e[0;35m' && read -p "Moniker isminizi girin: " MONIKER 
echo -e "\033[035mMoniker isminiz\033[034m $MONIKER \033[035molarak kaydedildi"
echo -e '\e[0m'
echo "export MONIKER=$MONIKER" >> $HOME/.bash_profile
echo "export BinaryName=$BinaryName" >> $HOME/.bash_profile
echo "export ChainID=$ChainID" >> $HOME/.bash_profile
echo "export CustomPort=$CustomPort" >> $HOME/.bash_profile
source $HOME/.bash_profile
sleep 2
echo -e ''
# remove old
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/remove-cosmos-node.sh | bash
echo -e "\e[0;34mSunucu Hazırlanıyor\033[0m"
# prepare server
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/preparing-server.sh | bash
echo -e "\e[0;34mGo Kuruluyor\033[0m"
# install go
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/install-go.sh | bash
echo -e "\e[0;33m$(go version) Kuruldu\033[0m"
# install binary
echo -e "\e[0;34m$BinaryName Kuruluyor\033[0m"
install_binary
echo -e "\e[0;33m$BinaryName $($BinaryName version) Kuruldu\033[0m"
sleep 1
echo -e "\e[0;34mYapılandırma Dosyası Ayarları Yapılıyor\033[0m"
# init
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/init.sh | bash
# config
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/config.sh | bash
# service
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/systemctl.sh | bash
# start
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/startnode.sh | bash
sleep 1
# print info
echo -e "\e[0;34mNode Başlatıldı\033[0m"
sleep 1
echo -e ""
echo -e "\e[0;32mLogları Görüntülemek İçin:\033[0;33m           sudo journalctl -u $BinaryName -fo cat\e[0m"
echo -e ""
echo -e ""
sleep 1
echo -e "\e[0;34mKurulum Tamamlandı\e[0m\u2600"
sleep 1
# Logo
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/socrates.sh | bash
# yıldız
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/y%C4%B1ld%C4%B1z.sh | bash


