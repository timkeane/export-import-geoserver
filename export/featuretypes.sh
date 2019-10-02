DIR=$1
wsName=$2
dsName=$3
sleep 5
echo
echo "retrieving featuretypes for datastore '$dsName' ..."
mkdir -p $DIR/workspaces/$wsName/datastores/$dsName/featuretypes
featuretypes=`curl $GS_REST/workspaces/$wsName/datastores/$dsName/featuretypes.json | jq '.featureTypes.featureType'`
for featuretype in $(echo "${featuretypes}" | jq -r '.[] | @base64'); do
  sleep 5
  _jq() {
    echo ${featuretype} | base64 --decode | jq -r ${1}
  }
  ftName=$(_jq '.name')
  echo
  echo "saving featuretype '$ftName' to './workspaces/$wsName/datastores/$dsName/featuretypes/$ftName.json' ..."
  echo
  curl $GS_REST/workspaces/$wsName/datastores/$dsName/featuretypes/$ftName.json > ./workspaces/$wsName/datastores/$dsName/featuretypes/$ftName.json
done  