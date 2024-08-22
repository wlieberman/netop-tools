#!/bin/bash
#
#
#
source ./netop.cfg
# Copyright (c) NVIDIA Corporation 2023
# https://github.com/k8snetworkplumbingwg/multus-cni/tree/master/examples#passing-down-device-information
cat << EOF > ./Network-Attachment-Definitions.yaml
---
apiVersion: "k8s.cni.cncf.io/v1"
kind: NetworkAttachmentDefinition
metadata:
  name: ${NETOP_NETWORK}
  #namespace: ${NETOP_NAMESPACE}
  namespace: default
  annotations:
    k8s.v1.cni.cncf.io/resourceName: nvidia.com/mlnxnics
spec:
  config: |-
    {
      "cniVersion": "0.3.1",
      "name": "${NETOP_NETWORK}",
      "plugins": [
        {
          "type": "sriov",
          "ipam": {
            "type": "${NETWORK_TYPE}",
            "poolName": "${NETOP_NETWORK_POOL}"
          }
        }
      ]
    }
EOF
#from inside config "name": "sriov-rdma-net",
#kubectl apply set-last-applied -f ./Network-Attachment-Definitions.yaml --create-annotation
kubectl apply -f ./Network-Attachment-Definitions.yaml
