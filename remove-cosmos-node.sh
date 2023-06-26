sudo systemctl stop $binaryname && \
sudo systemctl disable $binaryname && \
rm /etc/systemd/system/$binaryname.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .$binaryname && \
rm -rf $nodename && \
rm -rf $(which $binaryname)
