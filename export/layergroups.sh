#!/usr/bin/env bash

EXPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
wsName=$2
sleep 1
echo
echo "Retrieving layergroups for workspace '$wsName' ..."
echo
mkdir -p $EXPORT_PATH/namespaces/$wsName/layergroups
layergroups=`curl $GS_REST/workspaces/$wsName/layergroups.json | jq '.layerGroups.layerGroup'`
for layergroup in $(echo "${layergroups}" | jq -r '.[] | @base64'); do
  sleep 1
  _jq() {
    echo ${layergroup} | base64 --decode | jq -r ${1}
  }
  lgName=$(_jq '.name')
  mkdir -p $EXPORT_PATH/namespaces/$wsName/layergroups/$lgName
  echo
  echo "Saving layergroup '$lgName' to '$EXPORT_PATH/namespaces/$wsName/layergroups/$lgName/layergroup.json' ..."
  echo "curl $GS_REST/workspaces/$wsName/layergroups/$lgName.json > $EXPORT_PATH/namespaces/$wsName/layergroups/$lgName/layergroup.json"
  curl $GS_REST/workspaces/$wsName/layergroups/$lgName.json > $EXPORT_PATH/namespaces/$wsName/layergroups/$lgName/layergroup.json
  cat $EXPORT_PATH/namespaces/$wsName/layergroups/$lgName/layergroup.json | jq .
  echo
done