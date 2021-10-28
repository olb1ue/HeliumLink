# Freeing Space on a Helium DIY Miner
These steps will free up some space on your DIY miner. You're miner will need to resync to the blockchain. How long it will need to sync depends on how old the latest blessed snapshot is from Helium.

## Stop The Miner

```console
docker stop miner
```

## Remove .db directories
**WARNING: Be sure to [backup your](https://docs.helium.com/mine-hnt/build-a-packet-forwarder#backing-up-your-swarm-keys) `swarm_key` file before tampering with any files or directories in your `miner_data` directory**

```console
sudo rm -rf miner_data/blockchain.db
sudo rm -rf miner_data/ledger.db
```

## Restart Miner 


Restart the miner and it will see that the ledger and blockchain directories are empty and pull the snapshot from its config. It may take a few hours to resync, but you will have much more free space on your miner :)

```console
docker start miner
```
