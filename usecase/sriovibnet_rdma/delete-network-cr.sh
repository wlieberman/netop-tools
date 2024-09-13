#!/bin/bash -x
#
# delete the host networks crs, and the ip pool
#
source ${NETOP_ROOT_DIR}/global_ops.cfg
#
# delete the resources defined in the SriovNetwork configuration files
#   sriov node policy file
#   NetworkAttachmentDefinition file
#   sriov network CRD file
#

for DEVDEF in ${NETOP_NETLIST[@]};do
  NIDX=`echo ${DEVDEF}|cut -d',' -f1`
  DIR="${NETOP_ROOT_DIR}/usecase/${USECASE}"
  FILES=( "sriovibnet-node-policy-${NIDX}.yaml" "Network-Attachment-Definitions-${NIDX}.yaml" "${NETOP_NETWORK_NAME}-${NIDX}-cr.yaml" )
  for FILE in ${FILES[@]};do
    FILE="${DIR}/${FILE}"
    if [ -f ${FILE} ];then
      kubectl delete -f ${FILE}
    else
      echo "WARNING:not found:${FILE}"
    fi
  done
done
#
# make sure the ip pool is created
#
if [ "${IPAM_TYPE}" = "nv-ipam" ];then
  FILE="${NETOP_ROOT_DIR}/usecase/${USECASE}/ippool.yaml"
  if [ -f ${FILE} ];then
    kubectl delete -f ${FILE}
  else
    echo "WARNING:not found:${FILE}"
  fi
fi
#
# verify the network devices
#
${NETOP_ROOT_DIR}/ops/getnetwork.sh
