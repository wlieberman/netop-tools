#!/bin/bash
#
#
echo NetworkAttachmentDefinitions
kubectl get Network-Attachment-Definitions -A
echo HostDeviceNetwork
kubectl get HostDeviceNetwork -A
echo get NicClusterPolicy
kubectl get NicClusterPolicy nic-cluster-policy
echo "check node rdma device status"
NODES=`kubectl get nodes | grep worker | grep -v SchedulingDisabled | cut -d' ' -f1`
for NODE in ${NODES};do
  echo "node:${NODE}"
  kubectl describe node ${NODE} | grep rdma
  ops/checkippool.sh ${NODE}
  kubectl get pods -o=custom-columns='NAME:metadata.name,NODE:spec.nodeName,NETWORK-STATUS:metadata.annotations.k8s\.v1\.cni\.cncf\.io/network-status'  -A  --field-selector spec.nodeName=${NODE}
done
