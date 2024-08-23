#!/bin/bash
#
# setup the host networks, and make the nvipam ip pool
#
source ./netop.cfg
./ops/mk-hostnet-nvipam-cr.sh ${NETOP_NETWORK_NAME} a b
NETWORKS=$(ls ${NETOP_NETWORK_NAME}*.yaml)
for NETWORK in ${NETWORKS[@]};do
  kubectl apply -f ./${NETWORK}
done
#
# verify the network devices
#
kubectl get  ${NETOP_NETWORK_TYPE}
#
# make sure the ip pool is created
#
./ops/mk-nvipam.sh
kubectl apply -f ippool.yaml
