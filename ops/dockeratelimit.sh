#!/bin/bash
#
#
#
if [ "$#" -lt 1 ];then
  echo "usage:$0 {PASSWD}"
  exit 1
fi
#TOKEN=$(curl "https://auth.docker.io/token?service=registry.docker.io&scope=repository:ratelimitpreview/test:pull" | jq -r .token)
TOKEN=$(curl --user "thuff:${1}" "https://auth.docker.io/token?service=registry.docker.io&scope=repository:ratelimitpreview/test:pull" | jq -r .token)
curl --head -H "Authorization: Bearer ${TOKEN}" https://registry-1.docker.io/v2/ratelimitpreview/test/manifests/latest
