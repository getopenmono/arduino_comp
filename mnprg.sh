#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Missing VERSION or MONOPROG_PATH argument! (${#})\n"
	echo "Usage: $0 VERSION MONOPROG_PATH"
	exit
fi

VERSION=$1
SOURCE=$2
TARGET="$(basename $SOURCE)$VERSION.tar.bz2"

tar -cjf $TARGET -C . --exclude "*.DS_*" $SOURCE 
