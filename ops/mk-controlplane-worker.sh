#!/bin/bash
#
# by default control planes are schedulable for worker tasks
# label the control plane as a worker
# remove the node-role.kubernetes.io/control-plane:NoSchedule Taint makes it scheduleable
# k describe nodes bu-fae1 | grep -i sched
# Taints:             node-role.kubernetes.io/control-plane:NoSchedule
source ${NETOP_ROOT_DIR}/ops/labelworker.sh ${1}
kubectl taint nodes ${1} node-role.kubernetes.io/control-plane-
