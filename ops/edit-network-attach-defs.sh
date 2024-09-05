#!/bin/bash
#
#
source ${NETOP_ROOT_DIR}/global_ops.cfg
kubectl edit Network-Attachment-Definitions -o yaml -n ${NETOP_NAMESPACE}
