#!/usr/bin/env bash

IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
wsName=$2
echo
echo "Configuring layergroups for workspace '$wsName' ..."
layergroups=(`ls $IMPORT_PATH/namespaces/$wsName/layergroups`)
for lName in ${layergroups[*]}; do
  ENDPOINT="workspaces/$wsName/layergroups.json"
  METHOD="POST"
  sleep 1
  echo
  echo "Configuring layergroup '$lName' ..."
  echo "curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GS_REST/$ENDPOINT -d \"@${IMPORT_PATH}/namespaces/$wsName/layergroups/$lName/layergroup.json\" -H \"Content-Type: application/json\""
  status=$(curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GS_REST/$ENDPOINT -d "@${IMPORT_PATH}/namespaces/$wsName/layergroups/$lName/layergroup.json" -H "Content-Type: application/json")
  echo "HTTP Status $status"
  echo
done
