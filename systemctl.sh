#!/bin/bash
exec > /dev/null 2>&1
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
exec > /dev/tty 2>&1
