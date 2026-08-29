#!/bin/sh

. ./key_and_secret.shrc

url=https://192.168.122.99/api/netsnmp/general/set

cat - << EOF > data.json
{
  "general": {
    "enabled": "0"
  }
}
EOF
  
curl -s -u "$key:$secret" -k -X POST \
  -H "Content-Type: application/json" \
  $url -d @data.json | jq .


url=https://192.168.122.99/api/netsnmp/service/reconfigure

curl -s -u "$key:$secret" -k -X POST $url | jq .


