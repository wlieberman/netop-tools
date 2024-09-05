#!/bin/bash
#
# setup the host networks, and make the whereabouts ip pool
#
source ${NETOP_ROOT_DIR}/global_ops.cfg

for DEVDEF in ${NETOP_NETLIST[@]};do
  NIDX=`echo ${DEVDEF}|cut -d',' -f1`
  NIDXLST="${NIDXLST} ${NIDX}"
done
${NETOP_ROOT_DIR}/ops/mk-hostnet-ipam-cr.sh ${NETOP_NETWORK_NAME} ${NIDXLST}
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
#${NETOP_ROOT_DIR}/ops/mk-whereabouts.sh
#kubectl apply -f whereabouts.yaml
