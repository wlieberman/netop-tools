#!/bin/bash
#
# running from inside of the pod, 
# map the rmda device to the net device
# rdma show    will show all devices
# rdma link show  will show rdma dev to net dev mapping
# 
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/configuring_infiniband_and_rdma_networks/index
#
NETDEV="${1}"
shift
if [ "${NETDEV}" = "" ];then
  echo "usage:$0 {NETDEV}"
  exit 1
fi
rdma link show | grep "${NETDEV}" |  cut -d':' -f2 | cut -d'/' -f1 | tr -d [:space:]
