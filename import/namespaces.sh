IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
echo
echo "Configuring namespaces ..."
namespaces=(`ls $IMPORT_PATH/namespaces/`)
for wsName in ${namespaces[*]}; do
  sleep 1
  echo
  echo "Configuring namespace '$wsName' ..."
  echo "curl -X POST $GS_REST/namespaces.json -d \"@${IMPORT_PATH}/namespaces/$wsName/namespace.json\" -H \"Content-Type: application/json\""
  curl -X POST $GS_REST/namespaces.json -d "@${IMPORT_PATH}/namespaces/$wsName/namespace.json" -H "Content-Type: application/json"
  echo
  # ./$SCRIPT_PATH/EXPORT_PATHs.sh $IMPORT_PATH $wsName
  ./$SCRIPT_PATH/datastores.sh $IMPORT_PATH $wsName
done