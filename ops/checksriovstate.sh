#!/bin/bash
#
# get the SriovNetworkNodePolicy
#
source ${NETOP_ROOT_DIR}/global_ops.cfg
kubectl get -n ${NETOP_NAMESPACE} sriovnetworknodestate -o yaml
