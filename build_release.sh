#!/bin/bash

# Fetches needed dependent repositories, and builds them. Then packages an arduino release

if [ ! $MONO_FRM_URL ]; then MONO_FRM_URL="https://github.com/getopenmono/mono_framework.git"; fi
if [ ! $MONOPROG_URL ]; then MONOPROG_URL="https://github.com/getopenmono/monoprog.git"; fi
if [ ! $JSON_TEMPLATE ]; then JSON_TEMPLATE="package_openmono_index.json"; fi
if [ ! $FRAMEWORK_BRANCH ]; then FRAMEWORK_BRANCH="master"; fi
if [ ! $MONOPROG_BRANCH ]; then MONOPROG_BRANCH="master"; fi

if [ $# -lt 2 ]; then
	echo "Not enough arguments!"
	echo "Usage: build_release.sh RELEASE_VERSION MONOPROG_VERSION"
	echo ""
	exit 1
fi

RELEASE_VERSION=$1
MONOPROG_VERSION=$2

hash qmake
if  [ ! $? ]; then
	echo "ERROR: Qt environment does not exist!"
	echo "Qt 5.6 or later is required to build Mono SDK and monoprog"
	exit 1
fi

function assertOk {
	if [ ! -z $? ]; then
		echo "failed"
		exit 2
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

MONO_FILENAME=${MONO_FRM_URL##*/}
MONO_DIR=${MONO_FILENAME%.*}
echo "loading mono framework ($FRAMEWORK_BRANCH) $MONO_FRM_URL -> $MONO_DIR"
cloneOrUpdate $MONO_FRM_URL $FRAMEWORK_BRANCH || exit 1
echo "building framework..."
cd $MONO_DIR && \
gitRevision && \
bash resources/setup_icons.sh resources/icons.mk.tmp dist && \
make release || exit 1
cd ..

MONOPROG_FILENAME=${MONOPROG_URL##*/}
MONOPROG_DIR=${MONOPROG_FILENAME%.*}
echo "loading monoprog ($MONOPROG_BRANCH) $MONOPROG_URL -> $MONOPROG_DIR"
cloneOrUpdate $MONOPROG_URL $MONOPROG_BRANCH || exit 1
echo "building monoprog..."
cd $MONOPROG_DIR && \
gitRevision && \
cd src && \
./compile.sh || exit 1
cd ../.. || exit 1

echo "building mono SDK BZIP package..."
bash build_package.sh $RELEASE_VERSION $MONO_DIR/dist
assertOk

echo "Building monoprog BZIP package..."
ls -l $MONOPROG_DIR/src
#bash mnprg.sh $MONOPROG_VERSION $MONOPROG_DIR/
