# This script adds the education project files to the build
# this means adding them to an exiting checkout of Mono Framework

if [ ! $EDU_PROJECTS_REPO ]; then EDU_PROJECTS_REPO="https://github.com/getopenmono/opgaver.git"; fi
if [ ! $EDU_PROJECTS_BRANCH ]; then EDU_PROJECTS_BRANCH="master"; fi
if [ ! $MONO_DIR ]; then MONO_DIR="mono_framework"; fi

if [ ! -d $MONO_DIR ]; then
	echo "Mono Framework dir not found! ($MONO_DIR)"
	exit 1
fi

if [ ! hash node 2> /dev/null ]; then
	echo "Node.js does not seem to be installed!"
	exit 1
fi

function cloneOrUpdate {
	local URL=$1
	local FILENAME=${URL##*/}
	local DIR=${FILENAME%.*}
	local BRANCH=$2
	if [ -d $DIR ]; then
		cd $DIR && git pull --ff-only && cd ..
	else
		git clone -b $BRANCH $URL
	fi
}
cd $MONO_DIR/src
cloneOrUpdate $EDU_PROJECTS_REPO $EDU_PROJECTS_BRANCH || exit 1
EDU_REPONAME=${EDU_PROJECTS_REPO##*/}
EDU_DIRNAME=${EDU_REPONAME%.*}
cd $EDU_DIRNAME && node ./augment_makefile.js ../../Makefile && cd .. || exit 1
cd ..

