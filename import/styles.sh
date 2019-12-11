#!/usr/bin/env bash

IMPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
wsName=$2
echo
echo "Configuring styles for workspace '$wsName' ..."
styles=(`ls $IMPORT_PATH/namespaces/$wsName/styles`)
for sld in "${styles[@]}"; do
  ENDPOINT="workspaces/$wsName/styles"
  METHOD="POST"
  sleep 1
  echo
  echo "Configuring style '$sld' ..."
  sName=${sld%.sld}
  sInfo="{\"style\":{\"name\":\"${sName}\",\"filename\":\"${sld}\"}}"
  echo "curl -s -o /dev/null -w '%{http_code}' -X $METHOD -H 'Content-Type: application/json' -d $sInfo $GS_REST/$ENDPOINT"
  status=$(curl -s -o /dev/null -w '%{http_code}' -X $METHOD -H 'Content-Type: application/json' -d $sInfo $GS_REST/$ENDPOINT)
  echo "HTTP Status $status"
  METHOD="PUT"
  echo "curl -s -o /dev/null -w '%{http_code}' -X $METHOD -H 'Content-Type: application/vnd.ogc.sld+xml' -d @$IMPORT_PATH/namespaces/$wsName/styles/$sld $GS_REST/$ENDPOINT/$sName"
  status=$(curl -s -o /dev/null -w '%{http_code}' -X $METHOD -H 'Content-Type: application/vnd.ogc.sld+xml' -d @$IMPORT_PATH/namespaces/$wsName/styles/$sld  $GS_REST/$ENDPOINT/$sName)
  echo "HTTP Status $status"
  echo
done
