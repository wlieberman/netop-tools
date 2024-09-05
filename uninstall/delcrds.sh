#!/bin/bash
#
# delete the crds
#
kubectl delete \
   -f ${NETOP_ROOT_DIR}/release/${NETOP_VERSION}/netop-chart//network-operator/crds \
   -f ${NETOP_ROOT_DIR}/release/${NETOP_VERSION}/netop-chart/network-operator/charts/sriov-network-operator/crds
