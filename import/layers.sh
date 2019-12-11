#!/usr/bin/env bash

IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
wsName=$2
echo
echo "Configuring layers for workspace '$wsName' ..."
layers=(`ls $IMPORT_PATH/namespaces/$wsName/layers`)
for lName in ${layers[*]}; do
  ENDPOINT="workspaces/$wsName/layers.json"
  METHOD="POST"
  sleep 1
  echo
  echo "Configuring layer '$lName' ..."
  echo "curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GS_REST/$ENDPOINT -d \"@${IMPORT_PATH}/namespaces/$wsName/layers/$lName/layer.json\" -H \"Content-Type: application/json\""
  status=$(curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GS_REST/$ENDPOINT -d "@${IMPORT_PATH}/namespaces/$wsName/layers/$lName/layer.json" -H "Content-Type: application/json")
  echo "HTTP Status $status"
  echo
done
