#!/bin/bash -x
#
# setup the host networks, and make the nvipam ip pool
#
source ./netop.cfg
#
# set the SriovNetwork node policy
#
./ops/mk-sriovpolicy.sh 0000:23:00.0 a
kubectl apply -f sriovnetwork-node-policy-a.yaml
./ops/mk-network-attachment.sh a
kubectl apply -f "./Network-Attachment-Definitions-a.yaml"
./ops/mk-sriovpolicy.sh 0000:24:00.0 b
kubectl apply -f sriovnetwork-node-policy-b.yaml
./ops/mk-network-attachment.sh b
kubectl apply -f "./Network-Attachment-Definitions-b.yaml"
#
# define the custom resource by network
#
./ops/mk-sriovnet-nvipam-cr.sh ${NETOP_NETWORK_NAME} a b
NETWORKS=$(ls ${NETOP_NETWORK_NAME}*.yaml)
for NETWORK in ${NETWORKS[@]};do
  kubectl apply -f ./${NETWORK}
done
#
# make sure the ip pool is created
#
./ops/mk-nvipam.sh
kubectl apply -f ippool.yaml
#
# verify the network devices
#
kubectl get  ${NETOP_NETWORK_TYPE}
