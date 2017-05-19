if [ $# -lt 1 ]; then
	echo "Not enough args! Usage: docker_run.sh VERSION [TARGET_DIR]"
	exit 1
fi

if [ $# -gt 1 ]; then
	DEPLOY_TARGET=$2
else
	DEPLOY_TARGET="$HOME/Desktop"
fi
	
echo "Deploy files are copied to $DEPLOY_TARGET"
docker run -tie RELEASE_VERSION=$1 -e DEPLOY_DIR=/Desktop -v $DEPLOY_TARGET:/Desktop monolit/arduinobuild