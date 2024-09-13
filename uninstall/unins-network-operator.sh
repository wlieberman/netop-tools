#!/bin/bash -x
#
# uninstall the network-operator and remove the namespace
#
source ${NETOP_ROOT_DIR}/global_ops.cfg
function del_network-ad()
{
  NETWORK_AD="network-attachment-definitions.k8s.cni.cncf.io"
  kubectl delete ${NETWORK_AD} $(k get ${NETWORK_AD} | grep -v NAME | cut -d' ' -f1)
  kubectl delete crd ${NETWORK_AD}
}
helm uninstall network-operator -n ${NETOP_NAMESPACE} --no-hooks
#${NETOP_ROOT_DIR}/uninstall/delcrds.sh   # no longer add crds, so nolonger delete
kubectl delete --force NicClusterPolicy nic-cluster-policy
kubectl delete --force sriovnetwork -n ${NETOP_NAMESPACE} ${NETOP_NETWORK}
kubectl patch crd/sriovnetworks.sriovnetwork.openshift.io -p '{"metadata":{"finalizers":[]}}' --type=merge
#
# manually deleting crds
#
#${NETOP_ROOT_DIR}/ops/getcrds.sh
${NETOP_ROOT_DIR}/usecase/${USECASE}/delete-network-cr.sh
kubectl delete crd `${NETOP_ROOT_DIR}/ops/getcrds.sh | egrep 'sriov|mellanox.com|nodefeature' | cut -d' ' -f1`
del_network-ad
kubectl delete --force ns "${NETOP_NAMESPACE}"
${NETOP_ROOT_DIR}/uninstall/delstucknamespace.sh "${NETOP_NAMESPACE}"
