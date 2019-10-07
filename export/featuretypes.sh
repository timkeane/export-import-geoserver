EXPORT_PATH=$1
wsName=$2
dsName=$3
sleep 1
echo
echo "Retrieving featuretypes for datastore '$dsName' ..."
echo
mkdir -p $EXPORT_PATH/namespaces/$wsName/datastores/$dsName/featuretypes
echo "curl $GS_REST/workspaces/$wsName/datastores/$dsName/featuretypes.json | jq '.featureTypes.featureType'"
featuretypes=`curl $GS_REST/workspaces/$wsName/datastores/$dsName/featuretypes.json | jq '.featureTypes.featureType'`
for featuretype in $(echo "${featuretypes}" | jq -r '.[] | @base64'); do
  sleep 1
  _jq() {
    echo ${featuretype} | base64 --decode | jq -r ${1}
  }
  ftName=$(_jq '.name')
  echo
  echo "Saving featuretype '$ftName' to '$EXPORT_PATH/namespaces/$wsName/datastores/$dsName/featuretypes/$ftName.json' ..."
  echo "curl $GS_REST/workspaces/$wsName/datastores/$dsName/featuretypes/$ftName.json > $EXPORT_PATH/namespaces/$wsName/datastores/$dsName/featuretypes/$ftName.json"
  echo
  curl $GS_REST/workspaces/$wsName/datastores/$dsName/featuretypes/$ftName.json > $EXPORT_PATH/namespaces/$wsName/datastores/$dsName/featuretypes/$ftName.json
  cat $EXPORT_PATH/namespaces/$wsName/datastores/$dsName/featuretypes/$ftName.json | jq .
  echo
done
