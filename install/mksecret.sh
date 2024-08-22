#!/bin/bash +x
#
# create a secrets file for nvstaging
#
source ./netop.cfg
#FILE="~/.docker/config.json"
#if [ "${PROD_VER}" = "0" ];then
  FILE="/root/.docker/config.json"
  ../uninstall/delsecret.sh
  docker login nvcr.io
  X=`kubectl get secret -n ${NETOP_NAMESPACE} | grep -c "${NGC_SECRET}"`
  if [ "${X}" = "0" ];then
    kubectl -n ${NETOP_NAMESPACE} create secret docker-registry ${NGC_SECRET} --docker-server=nvcr.io --docker-username="\$oauthtoken" --docker-password=${NGC_API_KEY}
    kubectl -n ${NETOP_NAMESPACE} create secret generic ${NGC_SECRET} --from-file=.dockerconfigjson=${FILE} --type=kubernetes.io/dockerconfigjson
  fi
  #kubectl -n network-operator create secret generic ngc-image-secret --from-file=.dockerconfigjson=~/.docker/config.json --type=kubernetes.io/dockerconfigjson
#fi
