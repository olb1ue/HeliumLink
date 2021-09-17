# Freeing Space on a Helium DIY Miner
This guide is for freeing up space on a [Helium DIY Miner](https://developer.helium.com/blockchain/run-your-own-miner). It assumes you've followed the steps in the linked tutorial from Helium. This process removes blockchain db files and updates your miner's config to the latest blessed snapshot which will be within the most recent `720` blocks. It should resync within 15 minutes. These steps could be placed in a script and setup as a monthly cron job for example.

## Stop The Miner

```console
docker stop miner
```

## Remove .db directories
**WARNING: Be sure to [backup your](https://docs.helium.com/mine-hnt/build-a-packet-forwarder#backing-up-your-swarm-keys) `swarm_key` file before tampering with any files or directories in your `miner_data` directory**

```console
sudo rm -rf miner_data/blockchain.db
sudo rm -rf miner_data/ledger.db
sudo rm -rf miner_data/checkpoints
```

## Create New Config

`create-blessed-config.sh` will create a `docker.config` file with the most recent blessed snapshot (within the last 720 blocks). </br>
It assumes the miner is running on the default ports for p2p (44158) and the gateway (1680). `docker.config` should be edited to reflect the correct ports if your miner isn't running on the default ports.

```console
wget https://raw.githubusercontent.com/olb1ue/HeliumLink/master/diy-freespace/create-blessed-config.sh

sudo chmod +x create-blessed-config.sh

./create-blessed-config.sh
```

## Copy New Config To Container

```console
version=$(docker exec miner ls /opt/miner/releases/ | grep 2)

docker cp docker.config miner:/opt/miner/releases/$version/sys.config
```

## Restart Miner 


Restart the miner and it will start looking for peers to download the most recent blessed snapshot from. Once that's done, the miner should start syncing and finish the process within 15-30 minutes and with a lot more space freed up :)
```console
docker start miner
```
