IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
echo
echo "Configuring workspaces ..."
workspaces=(`ls $IMPORT_PATH/workspaces/`)
for wsName in ${workspaces[*]}; do
  sleep 5
  echo
  echo "Configuring workspace '$wsName'"
  echo 'curl -d $IMPORT_PATH/workspaces/$wsName/workspace.json -H "Content-Type: application/json" $GS_REST/workspaces.json'

  curl -X POST $GS_REST/workspaces.json -d $IMPORT_PATH/workspaces/$wsName/workspace.json -H "Content-Type: application/json"
  # ./$SCRIPT_PATH/datastores.sh $EXPORT_PATH $wsName
done