#!/bin/bash
#
# get the SriovNetworkNodePolicy
#
source ./netop.cfg
kubectl get -n ${NETOP_NAMESPACE} sriovnetworknodestate -o yaml
