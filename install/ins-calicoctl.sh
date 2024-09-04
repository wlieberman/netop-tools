#!/bin/bash -ex
#
#
source ${NETOP_ROOT_DIR}/global_ops.cfg
curl -L https://github.com/projectcalico/calico/releases/download/${CALICO_VERSION}/calicoctl-linux-amd64 -o calicoctl
chmod +x calicoctl
mv calicoctl /usr/local/bin
