cd
mkdir -p cnode
cd cnode
mkdir -p config db sockets keys logs scripts
cd config
#checking the latest built for configs
export LAST_BUILD=$(curl -s https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/index.html | grep -e "This item has moved" |  sed -e 's/.*build\/\(.*\)\/download.*/\1/')
#downloading configs
wget -q -O mainnet-config.json https://hydra.iohk.io/build/${LAST_BUILD}/download/1/mainnet-config.json
wget -q -O mainnet-byron-genesis.json https://hydra.iohk.io/build/${LAST_BUILD}/download/1/mainnet-byron-genesis.json
wget -q -O mainnet-shelley-genesis.json https://hydra.iohk.io/build/${LAST_BUILD}/download/1/mainnet-shelley-genesis.json
wget -q -O mainnet-topology.json https://hydra.iohk.io/build/${LAST_BUILD}/download/1/mainnet-topology.json
#list downloaded files
ls -al mainnet*
cat > mainnet-topology.json << EOF
{
  "Producers": [
    {
      "addr": "relays-new.cardano-mainnet.iohk.io",
      "port": 3001,
      "valency": 2
    },
    {
      "addr": "relays.zorropool247.sg",
      "port": 3001,
      "valency": 1
    }
  ]
}
EOF
