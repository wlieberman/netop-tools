#!/bin/bash
#
# setup the host networks, and make the whereabouts ip pool
#
source ${NETOP_ROOT_DIR}/netop.cfg
#./ops/mk-hostnet-ipam-cr.sh ${NETOP_NETWORK_NAME} a b c
./ops/mk-hostnet-ipam-cr.sh ${NETOP_NETWORK_NAME} a b
NETWORKS=$(ls ${NETOP_NETWORK_NAME}*.yaml)
for NETWORK in ${NETWORKS[@]};do
  kubectl apply -f ./${NETWORK}
done
#
# verify the network devices
#
kubectl get ${NETOP_NETWORK_TYPE}
#
# make sure the ip pool is created
#
#./ops/mk-whereabouts.sh
#kubectl apply -f whereabouts.yaml
