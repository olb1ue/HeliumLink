# Refreshing Space


## Stop The Miner

```console
docker stop miner
```

## Remove .db directories

```console
sudo rm -rf miner_data/blockchain.db
sudo rm -rf miner_data/ledger.db
```

## Create New Config

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