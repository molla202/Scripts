sudo systemctl stop $BinaryName && \
sudo systemctl disable $BinaryName && \
rm /etc/systemd/system/$BinaryName.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .$BinaryName && \
rm -rf $nodename && \
rm -rf $(which $BinaryName)
