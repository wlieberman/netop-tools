#!/bin/bash
#
#
#
if [ "$#" -lt 1 ];then
  echo "usage:$0 {NAMESPACE}"
  exit 1
fi
kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --ignore-not-found --show-kind -n ${1}
