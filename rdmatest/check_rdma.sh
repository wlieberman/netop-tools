#!/bin/bash
#
#
RDMA=`lsmod | grep rdma | wc -l`
echo ${RDMA}
#rmmod rdma_cm rpcrdma ib_iser rdma_ucm
