#!/bin/bash
#
#
#
if [ "$#" -lt 1 ];then
  echo "usage:$0 {NETWORK_DEV}"
  echo "example:$0 a"
  exit 1
fi
DEV=${1}
shift
source ${NETOP_ROOT_DIR}/global_ops.cfg
FILE="./Network-Attachment-Definitions-${DEV}.yaml"
# Copyright (c) NVIDIA Corporation 2023
# https://github.com/k8snetworkplumbingwg/multus-cni/tree/master/examples#passing-down-device-information
cat << HEREDOC > ${FILE}
---
apiVersion: "k8s.cni.cncf.io/v1"
kind: NetworkAttachmentDefinition
metadata:
  name: ${NETOP_NETWORK_NAME}-${DEV}
  namespace: ${NETOP_APP_NAMESPACE}
  annotations:
    k8s.v1.cni.cncf.io/resourceName: nvidia.com/mlnxnics
spec:
  config: |-
    {
      "cniVersion": "0.3.1",
      "name": "${NETOP_NETWORK_NAME}-${DEV}",
      "plugins": [
        {
          "type": "sriov",
          "ipam": {
            "type": "${IPAM_TYPE}",
            "poolName": "${NETOP_NETWORK_POOL}"
          }
        }
      ]
    }
HEREDOC
#kubectl apply set-last-applied -f ./Network-Attachment-Definitions.yaml --create-annotation
