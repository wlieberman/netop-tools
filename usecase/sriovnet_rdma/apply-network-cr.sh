#!/bin/bash -x
#
# setup the host networks, and make the ip pool
# typically in a GPU/NIC system you'll deploy multiple parallel 2ndary networks.
#
source ${NETOP_ROOT_DIR}/global_ops.cfg
#
# set the SriovNetwork configuration files
#   sriov node policy file
#   NetworkAttachmentDefinition file
#   sriov network CRD file
#

for DEVDEF in ${NETOP_NETLIST[@]};do
  NIDX=`echo ${DEVDEF}|cut -d',' -f1`
  NDEV=`echo ${DEVDEF}|cut -d',' -f4-20`
  DIR="${NETOP_ROOT_DIR}/usecase/${USECASE}"
  ${NETOP_ROOT_DIR}/ops/mk-sriovnet-node-policy.sh ${NIDX} ${NDEV}
  kubectl apply -f "${DIR}/sriovnet-node-policy-${NIDX}.yaml"
  ${NETOP_ROOT_DIR}/ops/mk-sriovnet-network-attachment.sh ${NIDX}
  kubectl apply set-last-applied -f "${DIR}/Network-Attachment-Definitions-${NIDX}.yaml" --create-annotation
  ${NETOP_ROOT_DIR}/ops/mk-sriovnet-ipam-cr.sh ${NIDX}
  kubectl apply -f "${DIR}/${NETOP_NETWORK_NAME}-${NIDX}-cr.yaml"
done
#
# make sure the ip pool is created
#
if [ "${IPAM_TYPE}" = "nv-ipam" ];then
  ${NETOP_ROOT_DIR}/ops/mk-nvipam-pool.sh
  FILE="${NETOP_ROOT_DIR}/usecase/${USECASE}/ippool.yaml"
  kubectl apply -f ${FILE}
fi
#
# verify the network devices
#
${NETOP_ROOT_DIR}/ops/getnetwork.sh
