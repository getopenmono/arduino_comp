#!/bin/bash

# Writes a new json file for the Arduino Board Manager
# this creates a new 'package_openmono_index.json' file that contains a new release
# specification.w

MONO_URL="https://github.com/getopenmono/arduino_comp/releases/download/"

if [ $# -lt 5 ]; then
	echo "Missing arguments! (${#})"
	echo "Usage: $0 RELEASE_TAG_VERSION MONO_BZ2 MONOPROG_VERSION MAC_MONOPROG_BZ2 WIN_MONOPROG_BZ2"
	exit
fi

RELEASE_VERSION=$1
MONO_FILE=$2
MONOPROG_VERSION=$3
MAC_MONOPROG_FILE=$4
WIN_MONOPROG_FILE=$5
YES_TO_ALL=$6
JSON_FILE="package_openmono_index.json"
RELEASE_URL="$MONO_URL$RELEASE_VERSION"

echo -e "Will update $JSON_FILE with:\n\
	\tMono Framework version: $RELEASE_VERSION\n\
	\tFile: $MONO_FILE\n\
	\tMonoprog version: $MONOPROG_VERSION\n\
	\tWindow file: $WIN_MONOPROG_FILE\n\
	\tMac file: $MAC_MONOPROG_FILE\n
	\tRelease URL: $RELEASE_URL"
if [ $YES_TO_ALL != "-y" ]; then
	echo -e "\nContinue (y/n)?"
	read -r CONFIRM
	if [ $CONFIRM != "y" ]; then
		exit
	fi
fi

JSON_TEMP=$JSON_FILE.$RANDOM
TEMPLATE=$JSON_FILE.template

MONO_HASH=`md5sum $MONO_FILE | sed "s/  $MONO_FILE//"`
MONO_SIZE=`stat -c"%s" $MONO_FILE`

MAC_MONOPROG_HASH=`md5sum $MAC_MONOPROG_FILE | sed "s/  $MAC_MONOPROG_FILE//"`
MAC_MONOPROG_SIZE=`stat -c"%s" $MAC_MONOPROG_FILE`

WIN_MONOPROG_HASH=`md5sum $WIN_MONOPROG_FILE | sed "s/  $WIN_MONOPROG_FILE//"`
WIN_MONOPROG_SIZE=`stat -c"%s" $WIN_MONOPROG_FILE`

cp $TEMPLATE $JSON_TEMP

echo "Replacing Mono values in JSON file..."
sed -i -e "s/MONO_VERSION/$RELEASE_VERSION/" $JSON_TEMP
sed -i -e "s/MONO_NAME/$MONO_FILE/" $JSON_TEMP
sed -i -e "s/MONO_MD5_HASH/$MONO_HASH/" $JSON_TEMP
sed -i -e "s/MONO_SIZE/$MONO_SIZE/" $JSON_TEMP

echo "Replacing Mac Monoprog values in JSON file..."
sed -i -e "s/MONOPROG_VERSION/$MONOPROG_VERSION/" $JSON_TEMP

sed -i -e "s/MAC_MONOPROG_NAME/$MAC_MONOPROG_FILE/" $JSON_TEMP
sed -i -e "s/MAC_MONOPROG_MD5_HASH/$MAC_MONOPROG_HASH/" $JSON_TEMP
sed -i -e "s/MAC_MONOPROG_SIZE/$MAC_MONOPROG_SIZE/" $JSON_TEMP

echo "Replacing Win Monoprog values in JSON file..."
sed -i -e "s/WIN_MONOPROG_NAME/$WIN_MONOPROG_FILE/" $JSON_TEMP
sed -i -e "s/WIN_MONOPROG_MD5_HASH/$WIN_MONOPROG_HASH/" $JSON_TEMP
sed -i -e "s/WIN_MONOPROG_SIZE/$WIN_MONOPROG_SIZE/" $JSON_TEMP

echo "Inserting Server URL: $RELEASE_URL"
sed -i -e "s#MONO_URL#$RELEASE_URL#" $JSON_TEMP

mv $JSON_TEMP $JSON_FILE

if [ -f $JSON_TEMP-e ]; then
	rm $JSON_TEMP-e
fi

echo "Done!"