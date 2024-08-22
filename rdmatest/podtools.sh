#!/bin/bash
#
# copy RDMA tools to pod
#
POD="${1}"
kubectl cp ./get_rdma_dev.sh ${POD}:/root
kubectl cp ./ib_bw_test.sh ${POD}:/root
