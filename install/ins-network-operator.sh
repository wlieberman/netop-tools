#!/bin/bash -x
#
# install the network operator.
#
source ./netop.cfg
systemctl restart kubelet
#helm install -n ${NETOP_NAMESPACE} --create-namespace network-operator ./network-operator
X=`kubectl get ns | grep -c "^${NETOP_NAMESPACE} "`
if [ "${X}" = "0" ];then 
  kubectl create ns ${NETOP_NAMESPACE}
fi
./mksecret.sh
./applycrds.sh 
helm install -n ${NETOP_NAMESPACE} network-operator nvidia/network-operator -f ./values.yaml
