#!/bin/bash
#
#
#
source ./netop.cfg
cat << HEREDOC > ./sriovnetwork-node-policy.yaml
apiVersion: sriovnetwork.openshift.io/v1
kind: SriovNetworkNodePolicy
metadata:
  name: policy-1
  namespace: ${NETOP_NAMESPACE}
spec:
  deviceType: netdevice
  mtu: 1500
  nicSelector:
    vendor: "15b3"
  numVfs: 8
  priority: 90
  isRdma: true
  resourceName: sriov_resource
  nodeSelector:
    node-role.kubernetes.io/worker: ""
HEREDOC
