#!/usr/bin/env bash

EXPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
wsName=$2
sleep 1
echo
echo "Retrieving styles for workspace '$wsName' ..."
echo
mkdir -p $EXPORT_PATH/namespaces/$wsName/styles
styles=`curl $GS_REST/workspaces/$wsName/styles.json | jq '.styles.style'`
for style in $(echo "${styles}" | jq -r '.[] | @base64'); do
  sleep 1
  _jq() {
    echo ${style} | base64 --decode | jq -r ${1}
  }
  sName=$(_jq '.name')
  echo
  echo "Saving style '$sName' to '$EXPORT_PATH/namespaces/$wsName/styles/$sName.sld' ..."
  echo "curl $GS_REST/workspaces/$wsName/styles/$sName.sld > $EXPORT_PATH/namespaces/$wsName/styles/$sName.sld"
  curl $GS_REST/workspaces/$wsName/styles/$sName.sld > $EXPORT_PATH/namespaces/$wsName/styles/$sName.sld
  cat $EXPORT_PATH/namespaces/$wsName/styles/$sName.sld
  echo
done