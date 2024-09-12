#!/bin/bash
#
# setup the host networks, define the ip  pool
#
source ${NETOP_ROOT_DIR}/global_ops.cfg

for NIDXDEF in ${NETOP_NETLIST[@]};do
  NIDX=`echo ${NIDXDEF}|cut -d',' -f1`
  NDEV=`echo ${NIDXDEF}|cut -d',' -f4`
  ${NETOP_ROOT_DIR}/ops/mk-ipoib-ipam-cr.sh ${NDEV} ${NIDX}
  kubectl apply -f ${NETOP_NETWORK_NAME}-${NIDX}-cr.yaml
done
#
# make sure the ip pool is created
#
kubectl get ${NETOP_NETWORK_TYPE}
if [ "${IPAM_TYPE}" = "nv-ipam" ];then
  ${NETOP_ROOT_DIR}/ops/mk-nvipam-pool.sh
  kubectl apply -f ippool.yaml
fi
