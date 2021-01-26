# Freeing Space on a Helium DIY Miner
This guide is for freeing up space on a [Helium DIY Miner](https://developer.helium.com/blockchain/run-your-own-miner). It assumes you've followed the steps in the linked tutorial from Helium. This process removes blockchain db files and updates your miner's config to the latest blessed snapshot which will be within the most recent `720` blocks. It should resync within 15 minutes.

## Stop The Miner

```console
docker stop miner
```

## Remove .db directories
**WARNING: Be sure to [backup your](https://developer.helium.com/blockchain/run-your-own-miner#backing-up-your-swarm-keys) `swarm_key` file before tampering with any files or directories in your `miner_data` directory**

```console
sudo rm -rf miner_data/blockchain.db
sudo rm -rf miner_data/ledger.db
```

## Create New Config

This script assumes the miner is running on the default ports for p2p (44158) and the gateway (1680). </br>
`docker.config` should be edited to reflect the correct ports if your miner isn't running on the default ports.

```console
./create-blessed-config.sh
```

## Copy New Config To Container

```console
docker cp docker.config miner:/opt/miner/releases/0.1.0/sys.config
```

## Restart Miner - Let .db Directories Rebuild

```console
docker start miner
```