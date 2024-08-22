#!/bin/bash -x
#
# uninstall the network-operator and remove the namespace
#
source ./netop.cfg
helm uninstall network-operator -n ${NETOP_NAMESPACE} --no-hooks
#kubectl delete --force NicClusterPolicy nic-cluster-policy -n ${NETOP_NAMESPACE}
##### ./delcrds.sh   # no longer add crds, so nolonger delete
kubectl delete --force NicClusterPolicy nic-cluster-policy
kubectl delete --force sriovnetwork -n ${NETOP_NAMESPACE} ${NVNOP_NETWORK}
#kubectl patch crd/sriovnetworks.sriovnetwork.openshift.io -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl patch crd/sriovnetworks.sriovnetwork.openshift.io -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl delete --force ns "${NETOP_NAMESPACE}"
./delstucknamespace.sh "${NETOP_NAMESPACE}"
../ops/getcrds.sh
#
# manually deleting crds
#
kubectl delete crd `../ops/getcrds.sh | grep sriov | cut -d' ' -f1`
kubectl delete crd `../ops/getcrds.sh | grep mellanox.com | cut -d' ' -f1`
