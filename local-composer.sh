#!/usr/bin/env bash

app=${PWD}
appVendor=$app/vendor
if [ ! -f $app/composer.json ]; then
    echo "$app/composer.json don't exist"
    exit 128
fi

DIR_NAME=${PWD##*/} # current dir name

length=${#DIR_NAME}
last_char=${DIR_NAME:length-1:1}
[[ $last_char == "/" ]] && DIR_NAME=${DIR_NAME:0:length-1}; :

dockerComposerFileDir=/Development/composer-configs/$DIR_NAME
dockerComposerFile=$dockerComposerFileDir/docker-composer.json
if [ ! -f $dockerComposerFile ]; then
    mkdir -p $dockerComposerFileDir
    template=`cat /Development/template-composer.json`
    fileContent=${template/REPLACE/$DIR_NAME}
    echo "$fileContent" > "$dockerComposerFile"
fi

COMPOSER=$dockerComposerFile \
COMPOSER_VENDOR_DIR=$appVendor \
composer $1 $2 $3 $4 $5
