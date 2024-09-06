#!/bin/bash
#
# setup the host networks, and make the whereabouts ip pool
#
source ${NETOP_ROOT_DIR}/global_ops.cfg

for NIDXDEF in ${NETOP_NETLIST[@]};do
  NIDX=`echo ${NIDXDEF}|cut -d',' -f1`
  ${NETOP_ROOT_DIR}/ops/mk-hostnet-nvipam-cr.sh ${NIDX}
  kubectl apply -f ${NETOP_NETWORK_NAME}-${NIDX}.yaml
done
#
# verify the network devices
#
kubectl get ${NETOP_NETWORK_TYPE}
#
# make sure the ip pool is created
#
${NETOP_ROOT_DIR}/ops/mk-nvipam.sh
kubectl apply -f ippool.yaml

