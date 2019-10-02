EXPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
if [ "$EXPORT_PATH" == "" ]; then
  echo "You must specify an export directory argument."
  exit 1
fi
mkdir -p $EXPORT_PATH
if test -d "$EXPORT_PATH/workspaces"; then
  read -r -p "Directory '$EXPORT_PATH/workspaces' already exists. Delete? [y/n] " input
  case $input in
    [yY][eE][sS]|[yY])
      rm -rf $EXPORT_PATH/workspaces
    ;;
    [nN][oO]|[nN])
      exit 2
    ;;
  esac
fi
./$SCRIPT_PATH/workspaces.sh $EXPORT_PATH