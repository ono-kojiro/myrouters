#!/bin/sh

. ./apikey.shrc

url=https://192.168.122.99/api/core/system/status

echo "secret is $secret"
echo "hash is $hash"

curl -s -u "$key:$secret" -k $url | jq .

