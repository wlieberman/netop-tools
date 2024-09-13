#!/bin/bash -x
#
# configure the secondary network
#
source ${NETOP_ROOT_DIR}/global_ops.cfg
source ${NETOP_ROOT_DIR}/ops/mk-ipam-cr.sh
if [ "$#" -lt 1 ];then
  echo "usage:$0 {NETWORK INDEX}"
  echo "example:$0 a"
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
HEREDOC2
  mk_ipam_cr >> ${FILE}
done
# "gateway": "${NETOP_NETWORK_GW}" # for ipam config above may need to set depending on fabric design
#kubectl get sriovnetwork -A
#kubectl -n ${NETOP_NAMESPACE} get sriovnetworknodestates.sriovnetwork.openshift.io -o yaml
#kubectl get pod -n ${NETOP_NAMESPACE} | grep sriov
