#!/bin/bash -x
#
# configure the secondary network
#
source ${NETOP_ROOT_DIR}/global_ops.cfg
if [ "$#" -lt 1 ];then
  echo "usage:$0 {NETWORK_NIDX_LIST}"
  echo "example:$0 a b c d e f g h"
  exit 1
fi
for NIDX in ${*};do
FILE="${NETOP_NETWORK_NAME}-${NIDX}-cr.yaml"
cat <<HEREDOC1> ${FILE}
apiVersion: sriovnetwork.openshift.io/v1
kind: ${NETOP_NETWORK_TYPE}
metadata:
  name: "${NETOP_NETWORK_NAME}-${NIDX}"
  namespace: ${NETOP_NAMESPACE}
spec:
HEREDOC1
if [ "${NETOP_NETWORK_TYPE}" = "SriovNetwork" ];then
  echo "  vlan: ${NETOP_NETWORK_VLAN}" >> ${FILE}
else
  echo "  linkState: enable" >> ${FILE}
fi
cat <<HEREDOC2>> ${FILE}
  networkNamespace: "${NETOP_APP_NAMESPACE}"
  resourceName: "${NETOP_RESOURCE}_${NIDX}"
  ipam: |
    {
      "type": "${IPAM_TYPE}",
HEREDOC2
    case ${IPAM_TYPE} in
    ipam)
cat <<HEREDOC3>> ${FILE}
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/${IPAM_TYPE}.d/${IPAM_TYPE}.kubeconfig"
      },
      "range": "${NETOP_NETWORK_RANGE}",
      "exclude": [],
      "log_file": "/var/log/${IPAM_TYPE}.log",
      "log_level": "info"
HEREDOC3
      ;;
    nv-ipam)
cat <<HEREDOC4>> ${FILE}
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/${IPAM_TYPE}.d/${IPAM_TYPE}.kubeconfig"
      },
      "log_file": "/var/log/${NETWORK_TYPE}_${IPAM_TYPE}.log",
      "log_level": "debug",
      "poolName": "${NETOP_NETWORK_POOL}"
HEREDOC4
      ;;
    dhcp)
cat <<HEREDOC5>> ${FILE}
      "daemonSocketPath": "/run/cni/dhcp.sock",
      "request": [
        {
          "skipDefault": false,
          "option": "classless-static-routes"
        }
      ],
      "provide": [
        {
          "option": "host-name",
          "fromArg": "K8S_POD_NAME"
        }
      ]
HEREDOC5
      ;;
    esac
echo "    }" >> ${FILE}
done
# "gateway": "${NETOP_NETWORK_GW}" # for ipam config above may need to set depending on fabric design
#kubectl get sriovnetwork -A
#kubectl -n ${NETOP_NAMESPACE} get sriovnetworknodestates.sriovnetwork.openshift.io -o yaml
#kubectl get pod -n ${NETOP_NAMESPACE} | grep sriov
