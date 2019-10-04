IMPORT_PATH=$1
wsName=$2
SCRIPT_PATH="`dirname \"$0\"`"
echo
echo "Configuring namespaces ..."
namespaces=(`ls $IMPORT_PATH/workspaces/`)
for nsName in ${namespaces[*]}; do
  sleep 1
  echo
  echo "Configuring namespace '$nsName'"
  curl -X POST $GS_REST/namespaces.json -d "@${IMPORT_PATH}/workspaces/$wsName/namespace.json" -H "Content-Type: application/json"
done