IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
wsName=$2
echo
echo "Configuring datastores for workspace '$wsName' ..."
datastores=(`ls $IMPORT_PATH/namespaces/$wsName/datastores`)
for dsName in ${datastores[*]}; do
  ENDPOINT="workspaces/$wsName/datastores.json"
  METHOD="POST"
  # while [ true ]; do
    sleep 1
    echo
    echo "Configuring datastore '$dsName' ..."
    echo "curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GS_REST/$ENDPOINT -d \"@${IMPORT_PATH}/namespaces/$wsName/datastores/$dsName/datastore.json\" -H \"Content-Type: application/json\""
    status=$(curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GS_REST/$ENDPOINT -d "@${IMPORT_PATH}/namespaces/$wsName/datastores/$dsName/datastore.json" -H "Content-Type: application/json")
    echo "HTTP Status $status"
    # if [[ $status == "200" ]]; then
      ./$SCRIPT_PATH/featuretypes.sh $IMPORT_PATH $wsName $dsName
      # break
    # else
    #   ENDPOINT="workspaces/$wsName/datastores/$dsName.json"
    #   METHOD="PUT"
    # fi
    echo
  # done
done
