#!/bin/bash
#
#
if [ "$#" -lt 1 ];then
  echo "usage:$0 {NODENAME}"
  exit 1
fi
kubectl annotate node ${1} ipam.nvidia.com/ip-blocks="" -o json
