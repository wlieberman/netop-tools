#!/bin/bash -x
#
# setup the host networks, and make the nvipam ip pool
# typically in a GPU/NIC system you'll deploy multiple parallel 2ndary networks.
#
# in this example we are defining 2 networks a and b
# these are arbritary strings
# for example:
# a_0 a_1 b_0 b_1 would define 4 networks using 2 dual port nics
# a b c d e f g would define 8 network for 8 nics.
source ${NETOP_ROOT_DIR}/global_ops.cfg
#
# set the SriovNetwork configuration files
# sriov node policy file
# NetworkAttachmentDefinition file
# sriov network CRD file
#

for DEVDEF in ${NETOP_NETLIST[@]};do
  NIDX=`echo ${DEVDEF}|cut -d',' -f1`
  NDEV=`echo ${DEVDEF}|cut -d',' -f4-20`
  ${NETOP_ROOT_DIR}/ops/mk-sriovpolicy.sh ${NIDX} ${NDEV}
  kubectl apply -f sriovnetwork-node-policy-${NIDX}.yaml
  ${NETOP_ROOT_DIR}/ops/mk-network-attachment.sh ${NIDX}
  kubectl apply -f "./Network-Attachment-Definitions-${NIDX}.yaml"
  NIDXLST="${NIDXLST} ${NIDX}"
done
${NETOP_ROOT_DIR}/ops/mk-hostnet-nvipam-cr.sh ${NETOP_NETWORK_NAME} ${NIDXLST}
for NIDX in ${NIDXLST};do
  kubectl apply -f ${NETOP_NETWORK_NAME}-${NIDX}-cr.yaml
done
#
# verify the network devices
#
#kubectl get ${NETOP_NETWORK_TYPE}
#
# make sure the ip pool is created
#
#${NETOP_ROOT_DIR}/ops/mk-nvipam.sh
#kubectl apply -f ippool.yaml

# verify the network devices
#
${NETOP_ROOT_DIR}/ops/getnetwork.sh
