API_URL="http://tools.heliumlink.io/blessed/latest/"
DOCKER_CONFIG_URL="https://raw.githubusercontent.com/helium/miner/master/config/docker.config"

HEIGHT_RES=$(curl -s -w "\n%{http_code}" "${API_URL}height")

HEIGHT_HTTP_RES=$(echo "$HEIGHT_RES" | tail -n1)

# Check HTTP CODE for height
if [[ $HEIGHT_HTTP_RES -ne 200 ]];
then
	echo "Bad response from Server for height."
	exit 0
else
	HEIGHT=$(echo "$HEIGHT_RES" | head -n1)
fi


HASH_RES=$(curl -s -w "\n%{http_code}" "${API_URL}hash")

HASH_HTTP_RES=$(echo "$HASH_RES" | tail -n1)

# Check HTTP CODE for hash
if [[ $HASH_HTTP_RES -ne 200 ]];
then
	echo "Bad response from Server for hash."
	exit 0
else
	HASH=$(echo "$HASH_RES" | head -n1)
fi

wget $DOCKER_CONFIG_URL

sed -i "/^  {blockchain,/{N;s/$/\n      {blessed_snapshot_block_hash,\n      $HASH},/}" docker.config
sed -i "/^  {blockchain,/{N;s/$/\n      {blessed_snapshot_block_height, $HEIGHT},/}" docker.config
