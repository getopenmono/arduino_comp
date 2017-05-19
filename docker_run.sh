if [ $# -lt 1 ]; then
	echo "Not enough args! Usage: docker_run.sh VERSION"
	exit 1
fi

docker run -tie RELEASE_VERSION=$1 -e DEPLOY_DIR=/Desktop -v $HOME/Desktop:/Desktop monolit/arduinobuild