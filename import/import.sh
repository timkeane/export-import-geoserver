IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
if [ "$IMPORT_PATH" == "" ]; then
  echo "You must specify an import directory argument."
  exit 1
fi
./$SCRIPT_PATH/workspaces.sh $IMPORT_PATH
echo
echo Done.
