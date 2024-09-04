#!/bin/bash -x
#
# install the network operator.
#
source ${NETOP_ROOT_DIR}/global_ops.cfg
systemctl restart kubelet
#helm install -n ${NETOP_NAMESPACE} --create-namespace network-operator ./network-operator
X=`kubectl get ns | grep -c "^${NETOP_NAMESPACE} "`
if [ "${X}" = "0" ];then 
  kubectl create ns ${NETOP_NAMESPACE}
fi
${NETOP_ROOT_DIR}/install/mksecret.sh
helm install -n ${NETOP_NAMESPACE} network-operator nvidia/network-operator -f ${NETOP_ROOT_DIR}/usecase/${USECASE}/values.yaml
${NETOP_ROOT_DIR}/install/applycrds.sh 
