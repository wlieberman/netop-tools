#!/bin/bash
#
# the flow for creating a dev environment
#
#
source ./netop.cfg
DEVPOLICY="nic-cluster-policy.yaml"
# get the current policy if not defined
if [ ! -f ${DEVPOLICY} ];then
  kubectl get NicClusterPolicy nic-cluster-policy -o yaml > ${DEVPOLICY}
  ./uninstall-network-operator.sh
fi
# Delete all of the Meta data except name:
# Delete all of status
python3 edityaml.py ${DEVPOLICY} > ${DEVPOLICY}.dev
kubectl create ns ${NETOP_NAMESPACE}
make run
# Then apply policy ${DEVPOLICY}
kubectl apply -f ${DEVPOLICY}.dev
