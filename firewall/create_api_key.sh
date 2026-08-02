#!/bin/sh

secret=`openssl rand -hex 32`
echo "secret is $secret"

hash=`openssl passwd -6 "$secret"`

echo "hash is $hash"

key=`openssl rand -base64 48`

{
  echo "key=$key"
  echo "secret=$secret"
} | tee key_and_secret.shrc

echo "<apikeys>$key|$hash</apikeys>" | tee apikeys.xml





