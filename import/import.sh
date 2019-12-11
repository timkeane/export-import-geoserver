#!/usr/bin/env bash

IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
echo $SCRIPT_PATH
if [ "$IMPORT_PATH" == "" ]; then
  echo "You must specify an import directory argument."
  exit 1
fi
./$SCRIPT_PATH/namespaces.sh $IMPORT_PATH
echo
echo Done.
