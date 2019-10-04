IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
echo
echo "Configuring workspaces ..."
workspaces=(`ls $IMPORT_PATH/workspaces/`)
for wsName in ${workspaces[*]}; do
  sleep 1
  echo
  echo "Configuring workspace '$wsName'"
  echo "curl -X POST $GS_REST/workspaces.json -d "@${IMPORT_PATH}/workspaces/$wsName/workspace.json" -H "Content-Type: application/json""
  curl -X POST $GS_REST/workspaces.json -d "@${IMPORT_PATH}/workspaces/$wsName/workspace.json" -H "Content-Type: application/json"
  echo
  # ./$SCRIPT_PATH/namespaces.sh $IMPORT_PATH $wsName
  ./$SCRIPT_PATH/datastores.sh $IMPORT_PATH $wsName
done