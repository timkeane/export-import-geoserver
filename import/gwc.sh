#!/usr/bin/env bash

IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
echo
echo "Configuring gwc layers ..."
layers=(`ls $IMPORT_PATH/gwc/layers`)
for lName in ${layers[*]}; do
  ENDPOINT="layers"
  METHOD="POST"
  sleep 1
  echo
  echo "Configuring layer '$lName' ..."
  echo "curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GWC_REST/$ENDPOINT/$lName.j -d \"@${IMPORT_PATH}/namespaces/$wsName/layers/$lName/layer.json\" -H \"Content-Type: application/json\""
  status=$(curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GS_REST/$ENDPOINT -d "@${IMPORT_PATH}/namespaces/$wsName/layers/$lName/layer.json" -H "Content-Type: application/json")
  echo "HTTP Status $status"
  echo
done
