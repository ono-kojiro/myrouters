#!/bin/sh

. ./key_and_secret.shrc

url=https://192.168.122.99/api/core/system/status
curl -s -u "$key:$secret" -k $url | jq .

