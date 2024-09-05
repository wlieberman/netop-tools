#!/bin/bash
#
#
source ./${NETOP_ROOT_DIR}/global_ops.cfg
helm repo add nvidia https://helm.ngc.nvidia.com/nvidia
helm repo update
helm install network-operator nvidia/network-operator -n nvidia-network-operator --create-namespace --version v${NETOP_VERSION} --wait
