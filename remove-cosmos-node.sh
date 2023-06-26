#!/bin/bash
removenode() {
exec > /dev/null 2>&1
sudo systemctl stop $BinaryName && \
sudo systemctl disable $BinaryName && \
rm /etc/systemd/system/$BinaryName.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .$BinaryName && \
rm -rf $NodeName && \
rm -rf $(which $BinaryName)
exec > /dev/tty 2>&1
}
removenode
