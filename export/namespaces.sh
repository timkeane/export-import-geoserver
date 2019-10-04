EXPORT_PATH=$1
wsName=$2
SCRIPT_PATH="`dirname \"$0\"`"
echo "Retrieving namespaces ..."
echo
namespaces=`curl $GS_REST/namespaces.json | jq '.namespaces.namespace'`
for namespace in $(echo "${namespaces}" | jq -r '.[] | @base64'); do
  sleep 1
  _jq() {
    echo ${namespace} | base64 --decode | jq -r ${1}
  }
  nsName=$(_jq '.name')
  echo
  echo "Saving namespace '$nsName' to '$EXPORT_PATH/workspaces/$wsName/namespace.json' ..."
  echo "curl $GS_REST/namespaces/$wsName.json > $EXPORT_PATH/workspaces/$wsName/namespace.json"
  echo
  curl $GS_REST/namespaces/$wsName.json > $EXPORT_PATH/workspaces/$wsName/namespace.json
  cat $EXPORT_PATH/workspaces/$wsName/namespace.json | jq .
  echo
done