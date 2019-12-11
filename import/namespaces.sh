IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
echo
echo "Configuring namespaces ..."
namespaces=(`ls $IMPORT_PATH/namespaces/`)
for wsName in ${namespaces[*]}; do
  ENDPOINT="namespaces.json"
  METHOD="POST"
  # while [ true ]; do
    sleep 1
    echo
    echo "Configuring namespace '$wsName' ..."
    echo "curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GS_REST/$ENDPOINT -d \"@${IMPORT_PATH}/namespaces/$wsName/namespace.json\" -H \"Content-Type: application/json\""
    status=$(curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GS_REST/$ENDPOINT -d "@${IMPORT_PATH}/namespaces/$wsName/namespace.json" -H "Content-Type: application/json")
    echo "HTTP Status $status"
    # if [ $status -eq 200 ]; then
      ./$SCRIPT_PATH/sld.sh $IMPORT_PATH $wsName
      ./$SCRIPT_PATH/datastores.sh $IMPORT_PATH $wsName
      ./$SCRIPT_PATH/layers.sh $IMPORT_PATH $wsName
    #   break
    # else
    #   echo $status
    #   ENDPOINT="namespaces/$wsName.json"
    #   METHOD="PUT"
    # fi
    # echo
  # done
done