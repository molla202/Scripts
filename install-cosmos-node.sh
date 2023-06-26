#!/bin/bash
clear
# matrix (optional)
# Logo
# set variables
BinaryName = "noded"
nodename = "project"
binaryversion = "v.1.1"
ChainID = "chainid.l"
customport = "111"
# get moniker
echo -e '\e[0;35m' && read -p "Moniker isminizi girin: " MONIKER 
echo -e "\033[035mMoniker isminiz\033[034m $MONIKER \033[035molarak kaydedildi"
echo -e '\e[0m'
echo "export MONIKER=$MONIKER" >> $HOME/.bash_profile
echo "export BinaryName=$BinaryName" >> $HOME/.bash_profile
echo "export ChainID=$ChainID" >> $HOME/.bash_profile
echo -e ''

# remove old
removeold() {
sudo systemctl stop $BinaryName && \
sudo systemctl disable $BinaryName && \
rm /etc/systemd/system/$BinaryName.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .$BinaryName && \
rm -rf $nodename && \
rm -rf $(which $BinaryName)
}
removeold
# prepare server
# install go
# install binary
# init

init() {
$BinaryName config chain-id $ChainID
$BinaryName config keyring-backend test
$BinaryName config node tcp://localhost:${customport}57
$BinaryName init $MONIKER --chain-id $ChainID
}
init

# config

sed -i 's/max_num_inbound_peers =.*/max_num_inbound_peers = 50/g' $HOME/.$BinaryName/config/config.toml
sed -i 's/max_num_outbound_peers =.*/max_num_outbound_peers = 50/g' $HOME/.$BinaryName/config/config.toml
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.$BinaryName/config/app.toml
sleep 1
sed -i -e 's|^indexer *=.*|indexer = "null"|' $HOME/.$BinaryName/config/config.toml

sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${customport}58\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:${customport}57\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${customport}60\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${customport}56\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${customport}66\"%" $HOME/.$BinaryName/config/config.toml
sed -i -e "s%^address = \"tcp://localhost:1317\"%address = \"tcp://localhost:${customport}17\"%; s%^address = \":8080\"%address = \":${customport}80\"%; s%^address = \"localhost:9090\"%address = \"localhost:${customport}90\"%; s%^address = \"localhost:9091\"%address = \"localhost:${customport}91\"%; s%:8545%:${customport}45%; s%:8546%:${customport}46%; s%:6065%:${customport}65%" $HOME/.cascadiad/config/app.toml

# service
sudo systemctl stop $BinaryName
sudo systemctl disable $BinaryName
sudo rm -rf /etc/systemd/system/$BinaryName.service
sudo tee /etc/systemd/system/$BinaryName.service > /dev/null <<EOF
[Unit]
Description=$nodename Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which $BinaryName) start --home $HOME/.$BinaryName
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
sleep 1
# start
sudo systemctl daemon-reload
sudo systemctl enable $BinaryName
sudo systemctl start $BinaryName
sudo systemctl restart $BinaryName
sleep 2
# print info
# Logo
