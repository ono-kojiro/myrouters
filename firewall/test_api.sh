#!/bin/sh

. ./apikey.shrc

url=https://192.168.122.99/api/core/system/status
curl -s -u "$key:$secret" -k $url | jq .

