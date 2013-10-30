#!/bin/bash

#
# Source and destination Folder
#

SRC_FOLDER=${1%/}
DEST_FOLDER=${2%/}
EXCLUSION_FILE=$3

echo $SRC_FOLDER
echo $DEST_FOLDER
echo $EXCLUSION_FILE


#NOW=$(date +"%Y-%m-%d-%H%M%S")
#NOW=$(date +"%Y-%m-%d")
DEST=$DEST_FOLDER

#
# Create destination folder 
# if it doesn't already exists
#


if [ ! -d "$DEST" ]; then
	echo "Creating destination $DEST"
	mkdir -p $DEST
fi


#
# Starting backup
#

echo "Starting backup..."
echo "From: $SRC_FOLDER"
echo "To:   $DEST"

CMD="rsync"
CMD="$CMD -a --delete "
CMD="$CMD --progress"
CMD="$CMD --delete-excluded"
CMD="$CMD --archive"
if [ "$EXCLUSION_FILE" != "" ]; then
	CMD="$CMD --exclude-from \"$EXCLUSION_FILE\""
fi

CMD="$CMD $SRC_FOLDER/ $DEST/"

CMD="$CMD | grep -E '^deleting|[^/]$'"

echo "command:"
echo $CMD
eval $CMD
