#!/usr/bin/env bash

EXPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
wsName=$2
sleep 1
echo
echo "Retrieving layers for workspace '$wsName' ..."
echo
mkdir -p $EXPORT_PATH/namespaces/$wsName/layers
layers=`curl $GS_REST/workspaces/$wsName/layers.json | jq '.layers.layer'`
for layer in $(echo "${layers}" | jq -r '.[] | @base64'); do
  sleep 1
  _jq() {
    echo ${layer} | base64 --decode | jq -r ${1}
  }
  lName=$(_jq '.name')
  mkdir -p $EXPORT_PATH/namespaces/$wsName/layers/$lName
  echo
  echo "Saving layer '$lName' to '$EXPORT_PATH/namespaces/$wsName/layers/$lName/layer.json' ..."
  echo "curl $GS_REST/workspaces/$wsName/layers/$lName.json > $EXPORT_PATH/namespaces/$wsName/layers/$lName/layer.json"
  curl $GS_REST/workspaces/$wsName/layers/$lName.json > $EXPORT_PATH/namespaces/$wsName/layers/$lName/layer.json
  cat $EXPORT_PATH/namespaces/$wsName/layers/$lName/layer.json | jq .
  echo
done