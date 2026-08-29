#!/bin/sh

. ./key_and_secret.shrc

url=https://192.168.122.99/api/core/firmware/install/os-net-snmp

curl -s -u "$key:$secret" -k -X POST $url | jq .


