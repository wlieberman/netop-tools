#!/bin/bash
#
# configure the secondary network
#
if [ "$#" -lt 2 ];then
  echo "usage:$0 {NETWORK_NAME} {NETWORK_DEV_LIST}"
  echo "example:$0 net-rdma-sriov a b c d e f g h"
  exit 1
fi
source ./${NETOP_ROOT_DIR}/global_ops.cfg
NETWORK_NAME=${1}
shift
RESOURCE=`echo ${NETWORK_NAME}|cut -d'-' -f2-99|sed 's/-/_/g'`
for DEV in ${*};do
cat <<EOF> "${NETWORK_NAME}-${DEV}"-cr.yaml
apiVersion: sriovnetwork.openshift.io/v1
kind: SriovNetwork
metadata:
  name: "${NETOP_NETWORK}"
  namespace: ${NETOP_NAMESPACE}
spec:
  vlan: ${NETOP_NETWORK_VLAN}
  networkNamespace: "${NETOP_APP_NAMESPACE}"
  resourceName: "sriov_resource"
  ipam: |
    {
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/${NETWORK_TYPE}.d/${NETWORK_TYPE}.kubeconfig"
      },
      "log_file": "/tmp/${NETWORK_TYPE}.log",
      "log_level": "debug",
      "type": "${NETWORK_TYPE}",
      "poolName": "${NETOP_NETWORK_POOL}"
    }
HEREDOC
#kubectl get sriovnetwork -A
#kubectl -n ${NETOP_NAMESPACE} get sriovnetworknodestates.sriovnetwork.openshift.io -o yaml
#kubectl get pod -n ${NETOP_NAMESPACE} | grep sriov
