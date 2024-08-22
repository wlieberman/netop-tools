#!/bin/bash
#
#
source ./netop.cfg
kubectl edit Network-Attachment-Definitions -o yaml -n ${NETOP_NAMESPACE}
