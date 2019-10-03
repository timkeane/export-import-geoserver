EXPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
echo "Retrieving workspaces ..."
echo
mkdir $EXPORT_PATH/workspaces
workspaces=`curl $GS_REST/workspaces.json | jq '.workspaces.workspace'`
for workspace in $(echo "${workspaces}" | jq -r '.[] | @base64'); do
  sleep 5
  _jq() {
    echo ${workspace} | base64 --decode | jq -r ${1}
  }
  wsName=$(_jq '.name')
  mkdir $EXPORT_PATH/workspaces/$wsName
  echo
  echo "Saving workspace '$wsName' to '$EXPORT_PATH/workspaces/$wsName/workspace.json' ..."
  echo
  curl $GS_REST/workspaces/$wsName.json > $EXPORT_PATH/workspaces/$wsName/workspace.json
  ./$SCRIPT_PATH/datastores.sh $EXPORT_PATH $wsName
  echo
done