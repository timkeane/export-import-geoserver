#!/usr/bin/env bash

IMPORT_PATH=$1
wsName=$2
dsName=$3
echo
echo "Configuring featuretypes for datastore '$dsName' ..."
featuretypes=(`ls $IMPORT_PATH/namespaces/$wsName/datastores/$dsName/featuretypes`)
for ftName in ${featuretypes[*]}; do
  ENDPOINT="workspaces/$wsName/datastores/$dsName/featuretypes.json"
  METHOD="POST"
  # while [ true ]; do
    sleep 1
    echo
    echo "Configuring featuretype '${ftName/\.json/}' ..."
    echo "curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GS_REST/$ENDPOINT -d \"@${IMPORT_PATH}/namespaces/$wsName/datastores/$dsName/featuretypes/$ftName\" -H \"Content-Type: application/json\""
    status=$(curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GS_REST/$ENDPOINT -d "@${IMPORT_PATH}/namespaces/$wsName/datastores/$dsName/featuretypes/$ftName" -H "Content-Type: application/json")
    echo "HTTP Status $status"
    # if [[ $status == "200" ]]; then
    #   break
    # else
    #   ENDPOINT="workspaces/$wsName/datastores/$dsName/featuretypes/$ftName"
    #   METHOD="PUT"
    # fi
    echo
  # done
done
