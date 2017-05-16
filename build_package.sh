#!/bin/bash
# Takes a compiled release build of mono framework and packs it into a arduino compatible board taget
# that include Arduino APIs and then compresses it into a bzip

if [ $# -ne 2 ]; then
	echo "Missing VERSION or FRAMEWORK argument! (${#})\n"
	echo "Usage: $0 VERSION MONO_FRAMEWORK_PATH"
	exit
fi

VERSION=$1
DEST="dest.$RANDOM"
MONO_FRMWRK=$2
SOURCE=mono
SRC_MONO_POSITION=cores/arduino/mono
NAME="mono$VERSION.tar.bz2"
EXCLUDE="--exclude arduino_org --exclude arduinoComp --exclude .DS_Store --exclude ._*"
JSON_FILE="package_openmono_index.json"

if [ ! -d $MONO_FRMWRK ]; then
	echo "Mono framework path ($MONO_FRMWRK) not found!"
	exit
fi

if [ ! -d $MONO_FRMWRK/include ]; then
	echo "The path ($MONO_FRMWRK) does not seem to contain mono framework!"
	exit
fi

echo "Building Arduino software package v$VERSION..."
mkdir $DEST
cp -RP $SOURCE $DEST/.
echo "Removing symlinks..."
#rm `find $DEST -mindepth 1 -type l -print0`
cp -R $MONO_FRMWRK $DEST/$SOURCE/$SRC_MONO_POSITION
echo "Removing hidden files..."

echo "Compressing to bzip..."
tar -cjf $NAME $EXCLUDE -C $DEST mono

echo "Removing temporary dir..."
rm -r $DEST
