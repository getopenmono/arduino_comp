#!/bin/bash

# Fetches needed dependent repositories, and builds them. Then packages an arduino release

if [ ! $MONO_FRM_URL ]; then MONO_FRM_URL="https://github.com/getopenmono/mono_framework.git"; fi
if [ ! $MONOPROG_URL ]; then MONOPROG_URL="https://github.com/getopenmono/monoprog.git"; fi
if [ ! $JSON_TEMPLATE ]; then JSON_TEMPLATE="package_openmono_index.json"; fi
if [ ! $FRAMEWORK_BRANCH ]; then FRAMEWORK_BRANCH="master"; fi
if [ ! $MONOPROG_RELEASE ]; then MONOPROG_RELEASE="0.9.3"; fi
if [ ! $MONOPROG_MAC_URL ]; then MONOPROG_MAC_URL="https://github.com/getopenmono/arduino_comp/releases/download/1.6.1/monoprog0.9.3.tar.bz2"; fi
if [ ! $MONOPROG_WIN_URL ]; then MONOPROG_WIN_URL="https://github.com/getopenmono/arduino_comp/releases/download/1.6.1/monoprog_win0.9.3.tar.bz2"; fi
if [ ! $INCLUDE_EDU ]; then INCLUDE_EDU="yes"; fi

if [ $# -lt 1 ]; then
	echo "Not enough arguments!"
	echo "Usage: build_release.sh RELEASE_VERSION MONOPROG_VERSION"
	echo ""
	exit 1
fi

RELEASE_VERSION=$1

hash qmake
if  [ $? -ne 0 ]; then
	echo "ERROR: Qt environment does not exist!"
	echo "Qt 5.6 or later is required to build Mono SDK and monoprog"
	exit 1
fi

hash wget
if  [ $? -ne 0 ]; then
	echo "ERROR: wget is not installed!"
	echo "wget is required to download monoprog packages"
	exit 1
fi

function assertOk {
	if [ $? -ne 0 ]; then
		echo "failed"
		exit 2
	fi
}

function download {
	local URL=$1
	local FILENAME=${URL##*/}
	if [ ! -f $FILENAME ]; then
		wget -O $FILENAME $URL
	fi
}

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

function gitRevision {
	COMMIT=`git show --oneline -s`
	echo "Building commit: $COMMIT"
}

echo "Downloading Monoprog for Mac..."
download $MONOPROG_MAC_URL || exit 1

echo "Downloading Monoprog for Windows..."
download $MONOPROG_WIN_URL || exit 1

MONO_FILENAME=${MONO_FRM_URL##*/}
MONO_DIR=${MONO_FILENAME%.*}
echo "loading mono framework ($FRAMEWORK_BRANCH) $MONO_FRM_URL -> $MONO_DIR"
cloneOrUpdate $MONO_FRM_URL $FRAMEWORK_BRANCH || exit 1

if [ $INCLUDE_EDU == "yes" ]; then
	echo "Including education assignments in framework build..."
	bash include_edu.sh || exit 1
else
	echo "Not including education files in release!"
fi

echo "building framework..."
cd $MONO_DIR && \
gitRevision && \
bash resources/setup_icons.sh resources/icons.mk.tmp dist && \
make release || exit 1
cd ..

MONO_PACK_FILE="mono$RELEASE_VERSION.tar.bz2"
echo "building mono SDK BZIP package: $MONO_PACK_FILE..."
bash build_package.sh $RELEASE_VERSION $MONO_DIR/dist/mono || exit 1

MONOPROG_MAC_FILE=${MONOPROG_MAC_URL##*/}
MONOPROG_WIN_FILE=${MONOPROG_WIN_URL##*/}
bash packer.sh $RELEASE_VERSION $MONO_PACK_FILE $MONOPROG_RELEASE $MONOPROG_MAC_FILE $MONOPROG_WIN_FILE -y

if [[ $DEPLOY_DIR && -d $DEPLOY_DIR ]]; then
	echo "Copying results to $DEPLOY_DIR"
	cp $MONO_PACK_FILE $DEPLOY_DIR/.
	cp $MONOPROG_MAC_FILE $DEPLOY_DIR/.
	cp $MONOPROG_WIN_FILE $DEPLOY_DIR/.
	cp $JSON_TEMPLATE $DEPLOY_DIR/.
fi
