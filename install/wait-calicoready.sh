#!/bin/bash
#
#
source ./readytest.sh
PODLIST=( 2,calico-apiserver,calico-apiserver 1,calico-system,calico-kube-controllers 1,calico-system,calico-node 1,calico-system,calico-typha 1,calico-system,csi-node-driver 2,kube-system,coredns 1,tigera-operator,tigera-operator 2,kube-system,coredns )
nsReady
