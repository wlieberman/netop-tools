#!/bin/bash
#
# https://github.com/k8snetworkplumbingwg/sriov-network-operator/tree/master
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
  mtu: 9000
  nicSelector:
    vendor: "15b3"
    deviceID: "101b"
#   rootDevices:
#   - 23:00.0
#   - 24:00.0
  numVfs: 8
  priority: 90    # used to resolve multiple policy definitions, lower value, higher priority
  isRdma: true
  resourceName: sriov_resource
  nodeSelector:
    node-role.kubernetes.io/worker: ""
HEREDOC
