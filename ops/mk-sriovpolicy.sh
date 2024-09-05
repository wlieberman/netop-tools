#!/bin/bash
#
# https://github.com/k8snetworkplumbingwg/sriov-network-operator/tree/master
#
if [ "$#" -lt 2 ];then
  echo "usage:$0 {PCI_DEVICE} {NETWORK_DEV}"
  echo "example:$0 0000:24:00.0 a"
  exit 1
fi
source ./${NETOP_ROOT_DIR}/global_ops.cfg
PCI_DEVICE="${1}"
shift
DEV="${1}"
shift

cat << HEREDOC > ./sriovnetwork-node-policy-${DEV}.yaml
apiVersion: sriovnetwork.openshift.io/v1
kind: SriovNetworkNodePolicy
metadata:
  name: policy-${DEV}
  namespace: ${NETOP_NAMESPACE}
spec:
  deviceType: netdevice
  mtu: 9000
  nicSelector:
    vendor: "15b3"
    deviceID: "101b"
    rootDevices: [ "${PCI_DEVICE}" ]
  numVfs: 8
  priority: 90    # used to resolve multiple policy definitions, lower value, higher priority
  isRdma: true
  resourceName: ${NETOP_RESOURCE}_${DEV}
  nodeSelector:
    node-role.kubernetes.io/worker: ""
HEREDOC
