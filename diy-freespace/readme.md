# Freeing Space on a Helium DIY Miner
These steps will free up some space on your DIY miner. You're miner will need to resync to the blockchain. How long it will need to sync depends on how old the latest blessed snapshot is from Helium.

## Stop The Miner

```console
docker stop miner
```

## Remove All miner_data except the Swarm Key
**WARNING: Be sure to [backup your](https://docs.helium.com/mine-hnt/full-hotspots/become-a-maker/basic-miner-operation/#backing-up-your-swarm-keys) `swarm_key` file before tampering with any files or directories in your `miner_data` directory**

Deletes all files and directories in miner_data except for those named 'miner' and 'swarm_key'

```console
cd ~/miner_data/ && sudo rm -rf !("miner"|"swarm_key") && cd || echo "Error"
```

## Restart Miner 
Restart the miner and it will see that the ledger and blockchain directories are empty and pull the snapshot from its config. It may take a few hours to resync, but you will have much more free space on your miner :)

```console
docker start miner
```

## All in one command
Combines the three above commands into a single line

```console
docker stop miner && cd ~/miner_data/ && sudo rm -rf !("miner"|"swarm_key") && cd && docker start miner || echo "Error"
