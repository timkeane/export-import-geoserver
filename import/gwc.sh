#!/usr/bin/env bash

IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
wsName=$2
echo
echo "Configuring gwc layers ..."
layers=(`ls $IMPORT_PATH/gwc/layers/$wsName`)
for lName in ${layers[*]}; do
  ENDPOINT="layers/$wsName:$lName.xml"
  METHOD="PUT"
  sleep 1
  echo
  echo "Configuring layer '$lName' ..."
  echo $GWC_REST/$ENDPOINT
  echo "curl -s -o /dev/null -w '%{http_code}' -X $METHOD $GWC_REST/$ENDPOINT -d \"@${IMPORT_PATH}/gwc/layers/$wsName/$lName/layer.xml\" -H \"Content-Type: text/xml\""
  status=$(curl -w '%{http_code}' -d "@${IMPORT_PATH}/gwc/layers/$wsName/$lName/layer.xml" -X $METHOD -H "Content-Type: text/xml" $GWC_REST/$ENDPOINT)
  echo "HTTP Status $status"
  echo
done
