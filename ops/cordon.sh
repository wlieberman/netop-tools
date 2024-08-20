#!/bin/bash
#
# "cordon the worker nodes"
#
function cordon()
{
  NODES=`kubectl get nodes | grep worker | grep -v SchedulingDisabled | cut -d' ' -f1`
  for NODE in ${NODES};do
    echo "cordon ${NODE}"
    kubectl cordon ${NODE}
  done
}
#
# "uncordon the worker nodes"
#
function uncordon()
{
  NODES=`kubectl get nodes | grep worker | grep SchedulingDisabled | cut -d' ' -f1`
  for NODE in ${NODES};do
    echo "uncordon ${NODE}"
    kubectl uncordon ${NODE}
  done
}
