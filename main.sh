#!/bin/bash

if [ -z "$UPLOADER_MAC" ]
then
    echo '[+] Missing variable UPLOADER_MAC, please inform an valid mac address, with uppercase letters'
    exit -1
fi

if [ -z "$AUTH_TOKEN" ]
then
    echo '[+] Missing AUTH_TOKEN variable, creating credentials to Google Music'
else
    echo $AUTH_TOKEN | base64 -d > /auth.cred
fi

echo '[+] Starting music upload job'

while true
do
    /upload.py --cred /auth --delete-on-success --match --uploader-id $UPLOADER_MAC
    if [ -z "$AUTH_TOKEN" ]
    then
        AUTH_TOKEN=$(cat /auth.cred | base64 -w 0)
        echo '[+] Generated AUTH_TOKEN, please save it for further use'
        echo $AUTH_TOKEN
    fi
done
