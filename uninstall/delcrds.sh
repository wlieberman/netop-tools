#!/bin/bash
#
# delete the crds
#
kubectl delete \
   -f ./netop-chart//network-operator/crds \
   -f ./netop-chart/network-operator/charts/sriov-network-operator/crds
