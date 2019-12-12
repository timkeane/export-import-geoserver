#!/usr/bin/env bash

EXPORT_PATH=$1
SCRIPT_PATH="`dirname \"$0\"`"
sleep 1
echo
echo "Retrieving gwc layers ..."
echo
mkdir -p $EXPORT_PATH/gwc/layers
layers=`curl $GWC_REST/layers.json | jq`
echo
echo $GWC_REST
echo
for layer in $(echo "${layers}" | jq -r '.[]'); do
  sleep 1
  layer=$layer
  IFS=':' read -ra wsLayer <<< "$layer"
  echo ${wsLayer[0]}
  echo ${wsLayer[1]}
  mkdir -p $EXPORT_PATH/gwc/layers/${wsLayer[0]}
  mkdir -p $EXPORT_PATH/gwc/layers/${wsLayer[0]}/${wsLayer[1]}
  echo
  echo "Saving layer '$layer' to '$EXPORT_PATH/gwc/layers/${wsLayer[0]}/${wsLayer[1]}/layer.xml' ..."
  echo "curl $GWC_REST/layers/$layer.xml > $EXPORT_PATH/gwc/layers/${wsLayer[0]}/${wsLayer[1]}/layer.xml"
  curl $GWC_REST/layers/$layer.xml \
    | sed -E 's/^(<*.*) class=".*/\1>/' \
    | sed -E 's/<id>[^>]*>//g' \
    | sed -E '/^ *$/d' > $EXPORT_PATH/gwc/layers/${wsLayer[0]}/${wsLayer[1]}/layer.xml
  cat $EXPORT_PATH/gwc/layers/${wsLayer[0]}/${wsLayer[1]}/layer.xml
  echo
  echo $GWC_REST
  echo
done
