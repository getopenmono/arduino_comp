if [ $# -lt 1 ]; then
	echo "Not enough args! Usage: docker_run.sh VERSION [TARGET_DIR] [FRM_BRANCH]"
	exit 1
fi

if [ $# -gt 1 ]; then
	DEPLOY_TARGET=$2
else
	DEPLOY_TARGET="$HOME/Desktop"
fi

if [ $# -gt 2 ]; then
	FRAMEWORK_BRANCH=$3
else
	FRAMEWORK_BRANCH="production"
fi
	
echo "Deploy files are copied to $DEPLOY_TARGET"
echo "Using Frm branch: $FRAMEWORK_BRANCH"
docker run -tie RELEASE_VERSION=$1 -e DEPLOY_DIR=/Desktop -e FRAMEWORK_BRANCH=$FRAMEWORK_BRANCH -v $DEPLOY_TARGET:/Desktop monolit/arduino