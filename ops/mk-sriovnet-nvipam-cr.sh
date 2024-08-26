#!/bin/bash -x
#
# configure the secondary network
#
if [ "$#" -lt 2 ];then
  echo "usage:$0 {NETWORK_NAME} {NETWORK_DEV_LIST}"
  echo "example:$0 net-sriov-rdma a b c d e f g h"
  exit 1
fi
source ./netop.cfg
NETWORK_NAME=${1}
shift
RESOURCE=`echo ${NETWORK_NAME}|cut -d'-' -f2-99|sed 's/-/_/g'`
for DEV in ${*};do
cat <<HEREDOC> "${NETWORK_NAME}-${DEV}"-cr.yaml
apiVersion: sriovnetwork.openshift.io/v1
kind: ${NETOP_NETWORK_TYPE}
metadata:
  name: "${NETOP_NETWORK_NAME}-${DEV}"
  namespace: ${NETOP_NAMESPACE}
spec:
  vlan: ${NETOP_NETWORK_VLAN}
  networkNamespace: "${NETOP_NAMESPACE}"
  resourceName: "${RESOURCE}_${DEV}"
  ipam: |
    {
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/${NETWORK_TYPE}.d/${NETWORK_TYPE}.kubeconfig"
      },
      "log_file": "/tmp/${NETWORK_TYPE}.log",
      "log_level": "debug",
      "type": "${IPAM_TYPE}",
      "poolName": "${NETOP_NETWORK_POOL}"
    }
HEREDOC
done
