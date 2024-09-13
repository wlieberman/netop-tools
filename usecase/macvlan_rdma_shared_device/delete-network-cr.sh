#!/bin/bash
#
# delete the host networks, the ip  pool
#
# you'll need to define the VFs on thw orker nodes
# echo 0 > /sys/devices/pci0000:20/0000:20:01.5/0000:23:00.0/sriov_numvfs
#
source ${NETOP_ROOT_DIR}/global_ops.cfg

for NIDXDEF in ${NETOP_NETLIST[@]};do
  NIDX=`echo ${NIDXDEF}|cut -d',' -f1`
  FILE="${NETOP_NETWORK_NAME}-${NIDX}-cr.yaml"
  if [ -f ${FILE} ];then
    kubectl delete -f ${FILE}
  else
    echo "WARNING:not found:${FILE}"
  fi
done
#
# delete ippool 
#
kubectl get ${NETOP_NETWORK_TYPE}
if [ "${IPAM_TYPE}" = "nv-ipam" ];then
  FILE="ippool.yaml"
  if [ -f ${FILE} ];then
    kubectl delete -f ${FILE}
  else
    echo "WARNING:not found:${FILE}"
  fi
fi
