IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
echo
echo "Configuring namespaces ..."
namespaces=(`ls $IMPORT_PATH/namespaces/`)
for wsName in ${namespaces[*]}; do
  ENDPOINT="namespaces.json"
  METHOD="POST"
  while [ true ]; do
    sleep 1
    echo
    echo "Configuring namespace '$wsName' ..."
    echo "curl -v -X $METHOD $GS_REST/$ENDPOINT -d \"@${IMPORT_PATH}/namespaces/$wsName/namespace.json\" -H \"Content-Type: application/json\""
    status=$(curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GS_REST/$ENDPOINT -d "@${IMPORT_PATH}/namespaces/$wsName/namespace.json" -H "Content-Type: application/json")
    if [ "$status" -ne "200" ]; then
      echo $status
      ENDPOINT="namespaces/$wsName.json"
      METHOD="PUT"
    else
      ./$SCRIPT_PATH/datastores.sh $IMPORT_PATH $wsName
      break
    fi
    echo
  done
done