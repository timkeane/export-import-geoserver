DIR=$1
if [ "$DIR" == "" ]; then
  echo "You must specify an export directory argument."
  exit 1
fi
if test -d "$DIR/workspaces"; then
  read -r -p "Directory '$DIR/workspaces' already exists. Delete? [y/n] " input
  case $input in
    [yY][eE][sS]|[yY])
      rm -rf $DIR/workspaces
    ;;
    [nN][oO]|[nN])
      exit 2
    ;;
  esac
fi
echo
echo "retrieving workspaces ..."
echo
mkdir $DIR/workspaces
workspaces=`curl $GS_REST/workspaces.json | jq '.workspaces.workspace'`
for workspace in $(echo "${workspaces}" | jq -r '.[] | @base64'); do
  sleep 5
  _jq() {
    echo ${workspace} | base64 --decode | jq -r ${1}
  }
  wsName=$(_jq '.name')
  mkdir $DIR/workspaces/$wsName
  echo
  echo "saving workspace '$wsName' to './workspaces/$wsName/workspace.json' ..."
  echo
  curl $GS_REST/workspaces/$wsName.json > ./workspaces/$wsName/workspace.json
  ./datastores.sh $DIR $wsName
done