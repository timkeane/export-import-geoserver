DIR=$1
wsName=$2
sleep 5
echo
echo "retrieving datastores for workspace '$wsName' ..."
echo
mkdir -p $DIR/workspaces/$wsName/datastores
datastores=`curl $GS_REST/workspaces/$wsName/datastores.json | jq '.dataStores.dataStore'`
for datastore in $(echo "${datastores}" | jq -r '.[] | @base64'); do
  sleep 5
  _jq() {
    echo ${datastore} | base64 --decode | jq -r ${1}
  }
  dsName=$(_jq '.name')
  mkdir -p $DIR/workspaces/$wsName/datastores/$dsName
  echo
  echo "saving datastore '$dsName' to './workspaces/$wsName/datastores/$dsName/datastore.json' ..."
  echo
  curl $GS_REST/workspaces/$wsName/datastores/$dsName.json > ./workspaces/$wsName/datastores/$dsName/datastore.json
  ./featuretypes.sh $DIR $wsName $dsName
done