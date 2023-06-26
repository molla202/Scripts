#!/bin/bash
# initalize a cosmos node with variables
init() {
exec > /dev/null 2>&1
$BinaryName config chain-id $ChainID
$BinaryName config keyring-backend test
$BinaryName config node tcp://localhost:${customport}57
$BinaryName init $MONIKER --chain-id $ChainID > $HOME/init.txt
exec > /dev/tty 2>&1
}
init
