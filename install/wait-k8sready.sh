#!/bin/bash
#
#
source ${NETOP_ROOT_DIR}/install/readytest.sh
PODLIST=( 1,kube-system,etcd 1,kube-system,kube-apiserver 1,kube-system,kube-controller-manager 1,kube-system,kube-scheduler )
#PODLIST=( 1,kube-system,etcd 1,kube-system,kube-apiserver 1,kube-system,kube-controller-manager 1,kube-system,kube-proxy 1,kube-system,kube-scheduler )
nsReady
