#!/bin/bash
#
#
source ./${NETOP_ROOT_DIR}/global_ops.cfg
#ctr -n=k8s.io image import nvcr.io_nvstaging_mellanox_network-operator_v23.1.1-nvipam.1.tar
#crictl pull --creds '$oauthtoken':${NGC_API_KEY} nvcr.io/nvstaging/mellanox/network-operator:v${NETOP_VERSION}
crictl pull --creds '$oauthtoken':${NGC_API_KEY} harbor.mellanox.com/cloud-orchestration-dev/network-operator-bundle:v${NETOP_VERSION}
crictl pull --creds '$oauthtoken':${NGC_API_KEY} nvcr.io/nvstaging/mellanox/sriov-network-operator:network-operator-${NETOP_VERSION}
crictl pull --creds '$oauthtoken':${NGC_API_KEY} nvcr.io/nvstaging/mellanox/network-operator:v${NETOP_VERSION}

