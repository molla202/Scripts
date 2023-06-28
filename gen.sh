gen_add_peer() {
exec > /dev/null 2>&1
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/---/addrbook.json > $HOME/.$BinaryName/config/addrbook.json
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/----/genesis.json > $HOME/.$BinaryName/config/genesis.json
peers=" "
seeds=" "
sed -i -e 's|^seeds *=.*|seeds = "'$seeds'"|; s|^persistent_peers *=.*|persistent_peers = "'$peers'"|' $HOME/.$BinaryName/config/config.toml
# min gas price
exec > /dev/tty 2>&1
}
