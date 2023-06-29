#!/bin/bash
# böyle çalıştır: ./komutlar.sh > komutlar.md
# değişkenler
BinaryName="noded"
ChainID="chain-id"
Token="utoken"
Fees="xxxutoken" # fee miktarını token ismi ile yaz
NodeName="project"
CustomPort="port no" # kurulum scripti ile aynı yap
MinGas='sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"xxx$Token\"/" \$HOME/.$BinaryName/config/app.toml' # min gas price komutunu yaz
echo -e "<h1 align="center"> Komutlar </h1>"
echo " "
echo -e "#"
echo -e "<h1 align="center"> Cüzdan Yönetimi </h1>"
echo " "
echo -e "## Cüzdan Oluştur"
echo -e '```'
echo -e "$BinaryName keys add wallet"
echo -e '```'
echo -e "## Cüzdan Recover Et"
echo -e '```'
echo -e "$BinaryName keys add wallet --recover"
echo -e '```'
echo -e "## Cüzdanları Listele"
echo -e '```'
echo -e "$BinaryName keys list"
echo -e '```'
echo -e "## Cüzdan Sil"
echo -e '```'
echo -e "$BinaryName keys delete wallet"
echo -e '```'
echo -e "## Cüzdan Bakiyesini Sorgula"
echo -e '```'
echo -e "$BinaryName q bank balances \$($BinaryName keys show wallet -a)"
echo -e '```'
echo -e "#"
echo -e "<h1 align="center"> Validatör Yönetimi </h1>"
echo " "
echo -e "## Validatör Oluştur"
echo -e '```'
echo "$BinaryName tx staking create-validator \\"
echo "--amount 1000000$Token \\"
echo "--pubkey \$($BinaryName tendermint show-validator) \\"
echo "--moniker \"MONİKER_İSMİNİZ\" \\"
echo "--identity \"KEYBASE.İO_İD\" \\"
echo "--details \"DETAYLAR\" \\"
echo "--website \"WEBSİTE_LİNKİNİZ\" \\"
echo "--chain-id $ChainID \\"
echo "--commission-rate 0.05 \\"
echo "--commission-max-rate 0.20 \\"
echo "--commission-max-change-rate 0.01 \\"
echo "--min-self-delegation 1 \\"
echo "--from wallet \\"
echo "--gas-adjustment 1.5 \\"
echo "--gas auto \\"
echo "--fees $Fees \\"
echo "-y"
echo -e '```'
echo -e "## Validatörü Düzenle"
echo -e '```'
echo "$BinaryName tx staking edit-validator \\"
echo "--new-moniker \"MONİKER_İSMİNİZ\" \\"
echo "--identity \"KEYBASE.İO_İD\" \\"
echo "--details \"DETAYLAR\" \\"
echo "--website \"WEBSİTE_LİNKİNİZ\" \\"
echo "--chain-id $ChainID \\"
echo "--commission-rate 0.05 \\"
echo "--from wallet \\"
echo "--gas-adjustment 1.5 \\"
echo "--gas auto \\"
echo "--fees $Fees \\"
echo "-y"
echo -e '```'
echo -e "## Validatör Detayları"
echo -e '```'
echo -e "$BinaryName q staking validator \$($BinaryName keys show wallet --bech val -a)"
echo -e '```'
echo -e "## Validatör Unjail"
echo -e '```'
echo -e "$BinaryName tx slashing unjail --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --fees $Fees -y"
echo -e '```'
echo -e "## Jail Olma Sebebi"
echo -e '```'
echo -e "$BinaryName query slashing signing-info \$($BinaryName tendermint show-validator)"
echo -e '```'
echo -e "## Tüm Aktif Validatörleri Listele"
echo -e '```'
echo -e "$BinaryName q staking validators -oj --limit=3000 | jq '.validators[] | select(.status=="BOND_STATUS_BONDED")' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) + " \t " + .description.moniker' | sort -gr | nl"
echo -e '```'
echo -e "## Tüm İnaktif Validatörleri Listele"
echo -e '```'
echo -e "$BinaryName q staking validators -oj --limit=3000 | jq '.validators[] | select(.status=="BOND_STATUS_UNBONDED")' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) + " \t " + .description.moniker' | sort -gr | nl"
echo -e '```'
echo -e "<h1 align="center"> Token </h1>"
echo " "
echo -e "## Token Gönder"
echo -e '```'
echo -e "$BinaryName tx bank send wallet <HEDEF_CÜZDAN_ADRESİ> 1000000$Token --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --fees $Fees -y"
echo -e '```'
echo -e "## Delegate"
echo -e '```'
echo -e "$BinaryName tx staking delegate <VALOPER_ADRESİ> 1000000$Token --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --fees $Fees -y"
echo -e '```'
echo -e "## Kendi Validatörüne Delegate"
echo -e '```'
echo -e "$BinaryName tx staking delegate \$($BinaryName keys show wallet --bech val -a) 1000000$Token --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --fees $Fees -y"
echo -e '```'
echo -e "## Redelegate"
echo -e '```'
echo -e "$BinaryName tx staking redelegate <İLK_VALOPER_ADRESİ> <HEDEF_VALOPER_ADRESİ> 1000000$Token --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --fees $Fees -y"
echo -e '```'
echo -e "## Kendi Validatöründen Başka Validatöre Redelegate"
echo -e '```'
echo -e "$BinaryName tx staking redelegate \$($BinaryName keys show wallet --bech val -a) <VALOPER_ADRESİ> 1000000$Token --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --fees $Fees -y"
echo -e '```'
echo -e "## Unbond"
echo -e '```'
echo -e "$BinaryName tx staking unbond \$($BinaryName keys show wallet --bech val -a) 1000000$Token --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --fees $Fees -y"
echo -e '```'
echo -e "## Tüm Validatörlerden Komisyon ve Ödülleri Çekme"
echo -e '```'
echo -e "$BinaryName tx distribution withdraw-all-rewards --commission --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --fees $Fees -y"
echo -e '```'
echo -e "## Kendi Validatörünüze Ait Komisyon ve Ödülleri Çekme"
echo -e '```'
echo -e "$BinaryName tx distribution withdraw-rewards \$($BinaryName keys show wallet --bech val -a) --commission --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --fees $Fees -y"
echo -e '```'
echo -e "<h1 align="center"> Yönetim </h1>"
echo " "
echo -e "## Tüm Oylamaları Görüntüle"
echo -e '```'
echo -e "$BinaryName query gov proposals"
echo -e '```'
echo -e "## Oylama Detaylarını Görüntüle"
echo -e '```'
echo -e "$BinaryName query gov proposal <ID>"
echo -e '```'
echo -e "## Evet Oyu Ver"
echo -e '```'
echo -e "$BinaryName tx gov vote <ID> yes --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --fees $Fees -y"
echo -e '```'
echo -e "## Hayır Oyu Ver"
echo -e '```'
echo -e "$BinaryName tx gov vote <ID> no --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --fees $Fees -y"
echo -e '```'
echo -e "## Çekimser Oyu Ver"
echo -e '```'
echo -e "$BinaryName tx gov vote <ID> abstain --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --fees $Fees -y"
echo -e '```'
echo -e "## Hayır Oyu ve Veto Et"
echo -e '```'
echo -e "$BinaryName tx gov vote <ID> no_with_veto --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --fees $Fees -y"
echo -e '```'
echo -e "<h1 align="center"> Yapılandırma Ayarları </h1>"
echo " "
echo -e " ## Pruning"
echo -e '```'
echo "sed -i \\"
echo "  -e 's|^pruning *=.*|pruning = \"custom\"|' \\"
echo "  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = \"100\"|' \\"
echo "  -e 's|^pruning-keep-every *=.*|pruning-keep-every = \"0\"|' \\"
echo "  -e 's|^pruning-interval *=.*|pruning-interval = \"19\"|' \\"
echo "  \$HOME/.$BinaryName/config/app.toml"
echo -e '```'
echo -e "## İndexer Aç"
echo -e '```'
echo -e "sed -i -e 's|^indexer *=.*|indexer = "kv"|' \$HOME/.$BinaryName/config/config.toml"
echo -e '```'
echo -e "## İndexer Kapat"
echo -e '```'
echo -e "sed -i -e 's|^indexer *=.*|indexer = "null"|' \$HOME/.$BinaryName/config/config.toml"
echo -e '```'
echo -e "## Port Değiştir"
echo -e "> ### Port=$CustomPort"
echo -e '```'
echo "sed -i -e \"s%^proxy_app = \\\"tcp://127.0.0.1:26658\\\"%proxy_app = \\\"tcp://127.0.0.1:${CustomPort}58\\\"%; s%^laddr = \\\"tcp://127.0.0.1:26657\\\"%laddr = \\\"tcp://127.0.0.1:${CustomPort}57\\\"%; s%^pprof_laddr = \\\"localhost:6060\\\"%pprof_laddr = \\\"localhost:${CustomPort}60\\\"%; s%^laddr = \\\"tcp://0.0.0.0:26656\\\"%laddr = \\\"tcp://0.0.0.0:${CustomPort}56\\\"%; s%^prometheus_listen_addr = \\\":26660\\\"%prometheus_listen_addr = \\\":${CustomPort}66\\\"%\" \$HOME/.$BinaryName/config/config.toml"
echo "sed -i -e \"s%^address = \\\"tcp://localhost:1317\\\"%address = \\\"tcp://localhost:${CustomPort}17\\\"%; s%^address = \\\":8080\\\"%address = \\\":${CustomPort}80\\\"%; s%^address = \\\"localhost:9090\\\"%address = \\\"localhost:${CustomPort}90\\\"%; s%^address = \\\"localhost:9091\\\"%address = \\\"localhost:${CustomPort}91\\\"%; s%:8545%:${CustomPort}45%; s%:8546%:${CustomPort}46%; s%:6065%:${CustomPort}65%\" \$HOME/.$BinaryName/config/app.toml"
echo -e '```'
echo -e "## Min Gas Price Ayarla"
echo -e '```'
echo -e "$MinGas"
echo -e '```'
echo -e "## Prometheus Aktif Et"
echo -e '```'
echo -e "sed -i -e "s/prometheus = false/prometheus = true/" \$HOME/.$BinaryName/config/config.toml"
echo -e '```'
echo -e "## Zincir Verilerini Sıfırla"
echo -e '```'
echo -e "$BinaryName tendermint unsafe-reset-all --keep-addr-book --home \$HOME/.$BinaryName --keep-addr-book"
echo -e '```'
echo -e "<h1 align="center"> Durum Sorgulama ve Kontrol </h1>"
echo " "
echo -e "## Senkronizasyon Durumu"
echo -e '```'
echo -e "$BinaryName status 2>&1 | jq .SyncInfo"
echo -e '```'
echo -e "## Validatör Durumu"
echo -e '```'
echo -e "$BinaryName status 2>&1 | jq .ValidatorInfo"
echo -e '```'
echo -e "## Node Durumu"
echo -e '```'
echo -e "$BinaryName status 2>&1 | jq .NodeInfo"
echo -e '```'
echo -e "## Validatör Key Kontrol"
echo -e '```'
echo "[[ \$($BinaryName q staking validator \$($BinaryName keys show wallet --bech val -a) -oj | jq -r .consensus_pubkey.key) = \$($BinaryName status | jq -r .ValidatorInfo.PubKey.value) ]] && echo -e \"\\n\\e[1m\\e[32mTrue\\e[0m\\n\" || echo -e \"\\n\\e[1m\\e[31mFalse\\e[0m\\n\""
echo -e '```'
echo -e "## TX Sorgulama"
echo -e '```'
echo -e "$BinaryName query tx <TX_ID>"
echo -e '```'
echo -e "## Peer Adresini Öğren"
echo -e '```'
echo -e "echo \$($BinaryName tendermint show-node-id)@\$(curl -s ifconfig.me):\$(cat \$HOME/.$BinaryName/config/config.toml | sed -n '/Address to listen for incoming connection/{n;p;}' | sed 's/.*://; s/\".*//')"
echo -e '```'
echo -e "## Bağlı Peerleri Öğren"
echo -e '```'
echo -e "curl -sS http://localhost:${CustomPort}57/net_info | jq -r \".result.peers[] | \"\(.node_info.id)@\(.remote_ip):\(.node_info.listen_addr)\"\" | awk -F \":\" \"{print \$1\":\"\$NF}\""
echo -e '```'
echo -e "<h1 align="center"> Service Yönetimi </h1>"
echo " "
echo "## Servisi Etkinleştir"
echo -e '```'
echo "sudo systemctl enable $BinaryName"
echo -e '```'
echo "## Servisi Devre Dışı Bırak"
echo -e '```'
echo "sudo systemctl disable $BinaryName"
echo -e '```'
echo "## Servisi Başlat"
echo -e '```'
echo "sudo systemctl start $BinaryName"
echo -e '```'
echo "## Servisi Durdur"
echo -e '```'
echo "sudo systemctl stop $BinaryName"
echo -e '```'
echo "## Servisi Yeniden Başlat"
echo -e '```'
echo "sudo systemctl restart $BinaryName"
echo -e '```'
echo "## Servis Durumunu Kontrol Et"
echo -e '```'
echo "sudo systemctl status $BinaryName"
echo -e '```'
echo "## Servis Loglarını Kontrol Et"
echo -e '```'
echo "sudo journalctl -u $BinaryName -f --no-hostname -o cat"
echo -e '```'
echo -e "<h1 align="center"> Node Silmek </h1>"
echo " "
echo -e '```'
echo -e "sudo systemctl stop $BinaryName && sudo systemctl disable $BinaryName && sudo rm /etc/systemd/system/$BinaryName.service && sudo systemctl daemon-reload && rm -rf \$HOME/.$BinaryName && rm -rf \$HOME/$NodeName && sudo rm -rf \$(which $BinaryName)"
echo -e '```'
