#!/bin/bash
#
# setup the host networks, define the ip  pool
#
source ${NETOP_ROOT_DIR}/global_ops.cfg

for NIDXDEF in ${NETOP_NETLIST[@]};do
  NIDX=`echo ${NIDXDEF}|cut -d',' -f1`
  NDEV=`echo ${NIDXDEF}|cut -d',' -f4`
  ${NETOP_ROOT_DIR}/ops/mk-macvlan-ipam-cr.sh ${NDEV} ${NIDX}
  kubectl apply -f ${NETOP_NETWORK_NAME}-${NIDX}-cr.yaml
done
#
# verify the network devices
#
kubectl get ${NETOP_NETWORK_TYPE}
if [ "${IPAM_TYPE}" = "nv-ipam" ];then
  ${NETOP_ROOT_DIR}/ops/mk-nvipam-pool.sh
  kubectl apply -f ippool.yaml
fi
#
# make sure the ip pool is created
#
#${NETOP_ROOT_DIR}/ops/mk-whereabouts.sh
#kubectl apply -f whereabouts.yaml
