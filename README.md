# geoserver-rest

## prerequisites
- bash shell
- jq https://stedolan.github.io/jq/
- a `GS_REST` environment variable set to `http://<user>@<password>:<geoserver-host>:<geoserver-port>/geoserver/rest`

## export
bash scripts to export running geoserver configuration to a directory structure of json files

`./export.sh <export-dir>`

## import
bash scripts to import geoserver configuration from a directory structure of json files

`./import.sh <import-dir>`

### todo
- strip out passwords from export and inject into import 
