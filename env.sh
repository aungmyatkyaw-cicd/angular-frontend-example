#!/bin/sh
for i in $(env | grep MY_APP_)
do
	key=$(echo $i | cut -d '=' -f 1)
	value=$(echo $i | cut -d '=' -f 2-)
	sed -i "s|${key}|${value}|g" /usr/share/nginx/html/*.js
done
