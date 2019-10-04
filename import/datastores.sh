IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
wsName=$2
echo
echo "Configuring datastores ..."
datastores=(`ls $IMPORT_PATH/workspaces/$wsName/datastores`)
for dsName in ${datastores[*]}; do
  sleep 1
  echo
  echo "Configuring datastore '$dsName'"
  echo "curl -X POST $GS_REST/workspaces/$wsName/datastores.json -d "@${IMPORT_PATH}/workspaces/$wsName/datastores/$dsName/datastore.json" -H "Content-Type: application/json""
  curl -X POST $GS_REST/workspaces/$wsName/datastores.json -d "@${IMPORT_PATH}/workspaces/$wsName/datastores/$dsName/datastore.json" -H "Content-Type: application/json"
  echo
  ./$SCRIPT_PATH/featuretypes.sh $IMPORT_PATH $wsName $dsName
done
