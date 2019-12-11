#!/usr/bin/env bash

EXPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
sleep 1
echo
echo "Retrieving gwc layers ..."
echo
mkdir -p $EXPORT_PATH/gwc/layers
layers=`curl $GWC_REST/layers.json | jq`
for layer in $(echo "${layers}" | jq -r '.[]'); do
  sleep 1
  layer=$layer
  mkdir -p $EXPORT_PATH/gwc/layers/$layer
  echo
  echo "Saving layer '$layer' to '$EXPORT_PATH/gwc/layers/$layer/layer.json' ..."
  echo "curl $GWC_REST/layers/$layer.json > $EXPORT_PATH/gwc/layers/$layer/layer.json"
  curl $GWC_REST/layers/$layer.json > $EXPORT_PATH/gwc/layers/$layer/layer.json
  cat $EXPORT_PATH/gwc/layers/$layer/layer.json | jq .
  echo
done
