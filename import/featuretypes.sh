IMPORT_PATH=$1
wsName=$2
dsName=$3
echo
echo "Configuring featuretypes for datastore '$dsName' ..."
featuretypes=(`ls $IMPORT_PATH/namespaces/$wsName/datastores/$dsName/featuretypes`)
for ftName in ${featuretypes[*]}; do
  sleep 1
  echo
  echo "Configuring featuretype '${ftName/\.json/}' ..."
  echo "curl -X POST $GS_REST/workspaces/$wsName/datastores/$dsName/featuretypes.json -d \"@${IMPORT_PATH}/namespaces/$wsName/datastores/$dsName/featuretypes/$ftName\" -H \"Content-Type: application/json\""
  curl -X POST $GS_REST/workspaces/$wsName/datastores/$dsName/featuretypes.json -d "@${IMPORT_PATH}/namespaces/$wsName/datastores/$dsName/featuretypes/$ftName" -H "Content-Type: application/json"
  echo
done
