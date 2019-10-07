EXPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
wsName=$2
sleep 1
echo
echo "Retrieving datastores for workspace '$wsName' ..."
echo
mkdir -p $EXPORT_PATH/namespaces/$wsName/datastores
datastores=`curl $GS_REST/workspaces/$wsName/datastores.json | jq '.dataStores.dataStore'`
for datastore in $(echo "${datastores}" | jq -r '.[] | @base64'); do
  sleep 1
  _jq() {
    echo ${datastore} | base64 --decode | jq -r ${1}
  }
  dsName=$(_jq '.name')
  mkdir -p $EXPORT_PATH/namespaces/$wsName/datastores/$dsName
  echo
  echo "Saving datastore '$dsName' to '$EXPORT_PATH/namespaces/$wsName/datastores/$dsName/datastore.json' ..."
  echo "curl $GS_REST/workspaces/$wsName/datastores/$dsName.json > $EXPORT_PATH/namespaces/$wsName/datastores/$dsName/datastore.json"
  curl $GS_REST/workspaces/$wsName/datastores/$dsName.json > $EXPORT_PATH/namespaces/$wsName/datastores/$dsName/datastore.json
  cat $EXPORT_PATH/namespaces/$wsName/datastores/$dsName/datastore.json | jq .
  echo
  ./$SCRIPT_PATH/featuretypes.sh $EXPORT_PATH $wsName $dsName
  echo
done