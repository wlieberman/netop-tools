#!/bin/bash
#
# apply the crds
#
kubectl apply \
   -f ./netop-chart/network-operator/crds \
   -f ./netop-chart/network-operator/charts/sriov-network-operator/crds
