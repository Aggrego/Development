#!/usr/bin/env bash

STR=$1;

length=${#STR}
last_char=${STR:length-1:1}
[[ $last_char == "/" ]] && STR=${STR:0:length-1}; :

COMPOSER=/app/$STR/docker-composer.json \
COMPOSER_VENDOR_DIR=/app/$STR/vendor \
composer update