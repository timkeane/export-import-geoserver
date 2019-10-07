EXPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
echo "Retrieving namespaces ..."
echo
mkdir $EXPORT_PATH/namespaces
namespaces=`curl $GS_REST/namespaces.json | jq '.namespaces.namespace'`
for namespace in $(echo "${namespaces}" | jq -r '.[] | @base64'); do
  echo $namespace
  exit 0
  sleep 1
  _jq() {
    echo ${namespace} | base64 --decode | jq -r ${1}
  }
  wsName=$(_jq '.name')
  mkdir $EXPORT_PATH/namespaces/$wsName
  echo
  echo "Saving namespace '$wsName' to '$EXPORT_PATH/namespaces/$wsName/namespace.json' ..."
  echo "curl $GS_REST/namespaces/$wsName.json > $EXPORT_PATH/namespaces/$wsName/namespace.json"
  echo
  curl $GS_REST/namespaces/$wsName.json > $EXPORT_PATH/namespaces/$wsName/namespace.json
  cat $EXPORT_PATH/namespaces/$wsName/namespace.json | jq .
  echo
  ./$SCRIPT_PATH/datastores.sh $EXPORT_PATH $wsName
done